import { useState, useContext, useMemo } from "react";
import { FiBox } from "react-icons/fi";
import * as S from "./styles";
import * as GS from "../../styles";
import { GoalsSenderContext } from "../../contexts/GoalsSenderContext";
import { toast } from "react-toastify";
import api from "../../services/api";
import { UserContext } from "../../contexts/UserContext";
import { NuiContext } from "../../contexts/NuiContext";

const Fabrication = () => {
  const [activeItem, setActiveItem] = useState(0);
  const [amount, setAmount] = useState(0);
  const { productsAndStorage } = useContext(GoalsSenderContext);
  const { setVisible } = useContext(NuiContext);
  const { user } = useContext(UserContext);
  const { fabricationProducts, storage } = productsAndStorage;

  const fullCoast = useMemo(() => {
    return +fabricationProducts[activeItem].coastPerUnit * amount;
  }, [amount]);

  const handleOrderProduct = async () => {
    const response = JSON.parse(
      (
        await api.post(
          "/orderProducts",
          JSON.stringify({
            product: fabricationProducts[activeItem].spawn,
            qtd: amount,
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
        <FiBox /> Encomenda de produtos
      </S.Title>
      <S.Description>
        Faça a encomenda dos produtos que deseja produzir e deixa o resto com a
        gente!
      </S.Description>
      <S.Content>
        <S.Wrap>
          <S.ProductList>
            {fabricationProducts.map((product, index) => (
              <S.ItemProductList
                key={product.name}
                onClick={() => {
                  setActiveItem(index);
                }}
                className={index === activeItem ? "active" : ""}
              >
                <S.ImageProductWrap>
                  <img
                    src={`http://189.127.164.160/zero_inventory/${product.index}.png`}
                  />
                  <b>{product.name}</b>
                </S.ImageProductWrap>
                <S.ItemProductListInfo>
                  <S.Materials>
                    {product.materials.map((material) => (
                      <S.ItemMaterials key={material.index}>
                        <b>{material.qtd}</b> {material.index}
                      </S.ItemMaterials>
                    ))}
                  </S.Materials>
                </S.ItemProductListInfo>
              </S.ItemProductList>
            ))}
          </S.ProductList>
          <S.Label>Custo total:</S.Label>
          <GS.Input placeholder="Qtd." value={`$${fullCoast}`} disabled />
          <S.Label>Quantidade:</S.Label>
          <GS.BtnInLine>
            <GS.Input
              placeholder="Qtd."
              type="number"
              value={amount}
              onChange={(e) => setAmount(+e.target.value)}
            />
            <GS.ActionButton onClick={handleOrderProduct} className="normal">
              Produzir
            </GS.ActionButton>
          </GS.BtnInLine>
        </S.Wrap>
        <S.Wrap>
          <S.Storage>
            <S.Subtitle>
              <FiBox />
              Armazém
            </S.Subtitle>
            <S.Materials>
              {storage.map((product) => (
                <S.ItemMaterials key={product.name}>
                  <b>{product.qtd}</b> {product.name}
                </S.ItemMaterials>
              ))}
            </S.Materials>
          </S.Storage>
          <S.Storage>
            <S.Subtitle>
              <FiBox />
              Material Utilizado
            </S.Subtitle>
            <S.Materials>
              {fabricationProducts[activeItem].materials.map((product) => (
                <S.ItemMaterials key={product.index}>
                  <b>{product.qtd * amount}</b> {product.index}
                </S.ItemMaterials>
              ))}
            </S.Materials>
          </S.Storage>
        </S.Wrap>
      </S.Content>
    </S.Container>
  );
};

export default Fabrication;
