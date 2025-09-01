import { useState, useContext, useEffect, useMemo } from "react";
import Structure from "../Structure";
import * as S from "./styles";
import * as GS from "../../styles";
import { FiArchive, FiAward, FiClipboard, FiTrash2, FiX } from "react-icons/fi";
import api from "../../services/api";
import { UserContext } from "../../contexts/UserContext";
import { toast } from "react-toastify";
import { ModalContext } from "../../contexts/ModalContext";
import { GoalsDTO, MemberGoalDTO, ProductsDTO } from "../../DTOS/Goals";
import ProgressStatus from "../ProgressStatus";

const Metas = () => {
  const [goals, setGoals] = useState<GoalsDTO[]>([] as GoalsDTO[]);
  const [membersGoals, setMembersGoals] = useState([] as any[]);
  const [products, setProducts] = useState<ProductsDTO[]>([] as ProductsDTO[]);
  const [product, setProduct] = useState("");
  const [qtd, setQtd] = useState("");
  const { setModal } = useContext(ModalContext);
  const { user } = useContext(UserContext);

  const progressStatus = (metas: MemberGoalDTO[]) => {
    let totalGoal = 0;
    let totalUserGoal = 0;

    goals.map((goal) => {
      totalGoal += goal.qtd;
      metas.map((item) => {
        totalUserGoal += item.qtd;
      });
    });

    return <ProgressStatus userGoals={metas} goals={goals} />;
  };

  const getCurrentGoals = async () => {
    const response = JSON.parse(
      (
        await api.post(
          "/getCurrentGoals",
          JSON.stringify({
            fac: user.fac,
          })
        )
      ).data
    );
    setGoals(response);
  };

  const getAllMembersGoals = async () => {
    const response = JSON.parse(
      (
        await api.post(
          "/getAllMembersGoals",
          JSON.stringify({
            fac: user.fac,
          })
        )
      ).data
    );
    setMembersGoals(response);
  };

  const getProducts = async () => {
    const response = JSON.parse(
      (
        await api.post(
          "/getProducts",
          JSON.stringify({
            fac: user.fac,
          })
        )
      ).data
    );
    setProducts(response);
  };

  useEffect(() => {
    getAllMembersGoals();
    getProducts();
    getCurrentGoals();
  }, []);

  const handleSubmitGoal = () => {
    setModal({
      text: `Deseja registrar uma nova meta?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/registerCurrentGoal",
              JSON.stringify({
                fac: user.fac,
                product,
                qtd,
              })
            )
          ).data
        );
        getCurrentGoals();
        setProduct("");
        setQtd("");
        if (response.result === "success") {
          toast.success(response.message);
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };

  const handleDeleteAllMembersGoals = () => {
    setModal({
      text: `Deseja zerar as metas?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/deleteAllMembersGoals",
              JSON.stringify({
                fac: user.fac,
              })
            )
          ).data
        );
        getAllMembersGoals();
        if (response.result === "success") {
          toast.success(response.message);
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };

  const handleDeleteCurrentGoal = (id: number) => {
    setModal({
      text: `Deseja excluir esta meta?`,
      actionConfirm: async () => {
        const response = JSON.parse(
          (
            await api.post(
              "/deleteCurrentGoal",
              JSON.stringify({
                fac: user.fac,
                id,
              })
            )
          ).data
        );
        getCurrentGoals();
        setProduct("");
        setQtd("");
        if (response.result === "success") {
          toast.success(response.message);
        }
        if (response.result === "error") toast.error(response.message);
      },
    });
  };

  return (
    <Structure>
      <S.Container>
        <GS.Side>
          {user.role === "Lider" && (
            <>
              <GS.BtnInLine>
                <GS.ActionButton
                  className="error"
                  onClick={handleDeleteAllMembersGoals}
                >
                  <FiTrash2 /> Zerar metas
                </GS.ActionButton>
              </GS.BtnInLine>
              <S.Card>
                <GS.Title>
                  <FiArchive /> Registrar meta
                </GS.Title>
                <GS.Select
                  value={product}
                  onChange={(e) => setProduct(e.target.value)}
                  placeholder="Material/produto"
                >
                  <option value="">Selecione o produto</option>
                  <option value="" disabled></option>
                  {products.map((item) => (
                    <option key={item.index} value={item.index}>
                      {item.name}
                    </option>
                  ))}
                </GS.Select>
                <GS.Input
                  type="number"
                  value={qtd}
                  onChange={(e) => setQtd(e.target.value)}
                  placeholder="Qtd. da meta"
                />
                <GS.ActionButton onClick={handleSubmitGoal} className="success">
                  Adicionar
                </GS.ActionButton>
              </S.Card>
            </>
          )}
          <S.Card>
            <GS.Title>
              <FiArchive /> Meta Semanal
            </GS.Title>
            <S.GoalsList>
              {goals.map((item) => (
                <S.GoalItem key={item.product}>
                  {item.qtd} {item.product}
                  {user.role === "Lider" && (
                    <GS.ActionButton
                      onClick={() => handleDeleteCurrentGoal(item.id)}
                      className="error small-rounded"
                    >
                      <FiX />
                    </GS.ActionButton>
                  )}
                </S.GoalItem>
              ))}
            </S.GoalsList>
          </S.Card>
        </GS.Side>
        <GS.Table>
          <GS.Row className="headRow">
            <GS.Column>
              <FiAward /> ID
            </GS.Column>
            <GS.Column>
              <FiClipboard /> Nome
            </GS.Column>
            <GS.Column>
              <FiArchive /> Status da meta
            </GS.Column>
          </GS.Row>
          {membersGoals.map((item) => (
            <GS.Row key={item.user_id}>
              <GS.Column>#{item.user_id}</GS.Column>
              <GS.Column>{item.name}</GS.Column>
              <GS.Column>{progressStatus(item.goals)}</GS.Column>
            </GS.Row>
          ))}
        </GS.Table>
      </S.Container>
    </Structure>
  );
};

export default Metas;
