import { useContext, useEffect, useMemo, useState } from "react";
import { FiBox } from "react-icons/fi";
import * as S from "./styles";
import * as GS from "../../styles";
import { GoalsSenderContext } from "../../contexts/GoalsSenderContext";
import api from "../../services/api";
import { UserContext } from "../../contexts/UserContext";
import { toast } from "react-toastify";
import { NuiContext } from "../../contexts/NuiContext";

const GoalsSender = () => {
  const [selectedProduct, setSelectedProduct] = useState("");
  const [amount, setAmount] = useState("");
  const { productsAndStorage } = useContext(GoalsSenderContext);
  const { setVisible } = useContext(NuiContext);
  const { user } = useContext(UserContext);

  const productsWeight = useMemo(() => {
    const { products } = productsAndStorage;
    if (selectedProduct !== "") {
      const currentProductInfos = products.filter(
        (product) => product.index === selectedProduct
      )[0];
      return +currentProductInfos.weight * +amount ?? 0;
    }
    return 0;
  }, [productsAndStorage, amount, selectedProduct]);

  const handleSendGoal = async () => {
    const response = JSON.parse(
      (
        await api.post(
          "/sendGoal",
          JSON.stringify({
            product: selectedProduct,
            amount,
            fac: user.fac,
          })
        )
      ).data
    );

    if (response.result === "success") {
      toast.success(response.message);
      setVisible(`off`);
    }
    if (response.result === "error") toast.error(response.message);
  };

  return (
    <S.Container>
      <S.Title>
        <FiBox /> Entrega de Produtos
      </S.Title>
      <S.Description>
        Entregue os produtos para reabastecer o depósito da sua organização!
      </S.Description>
      <GS.Select
        value={selectedProduct}
        onChange={(e) => setSelectedProduct(e.target.value)}
      >
        <>
          <option value="">Selecionar produto</option>
          <option disabled></option>
          {productsAndStorage.products.map((product) => (
            <option key={product.index} value={product.index}>
              {product.name}
            </option>
          ))}
        </>
      </GS.Select>
      <GS.Input
        placeholder="Quantidade"
        value={amount}
        onChange={(e) => setAmount(e.target.value as string)}
      />
      <GS.Input
        placeholder="Peso"
        disabled={true}
        value={`${productsWeight} KGs/${productsAndStorage.storageWeightFree} KGs disponíveis`}
      />
      <GS.ActionButton onClick={handleSendGoal} className="normal">
        Entregar
      </GS.ActionButton>
    </S.Container>
  );
};

export default GoalsSender;
