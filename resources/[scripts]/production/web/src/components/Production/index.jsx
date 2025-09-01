import { useCallback, useContext, useEffect, useState } from "react";
import * as S from "./styles";
import Input from "../Input";
import useRequest from "../../hooks/useRequest";
import ProductionContext from "../../contexts/ProductionContext";

function Production({ data }) {
  const { setProduction } = useContext(ProductionContext);
  const [product, setProduct] = useState({});
  const [productIndex, setProductIndex] = useState("");
  const [amount, setAmount] = useState(1);
  const [blockProduction, setBlockProduction] = useState(false);
  const { request } = useRequest();

  useEffect(() => {
    if (amount < 1) setBlockProduction(true);
    else setBlockProduction(false);
  }, [amount]);

  const handleProduction = useCallback(() => {
    request("production", {
      index: productIndex,
      amount,
      org: data.org,
    });
    request("close");
    setProduction({});
  }, [request, productIndex, amount, data, setProduction]);

  const handleSelectProduct = (product) => {
    setProduct(data.products[product]);
    setProductIndex(product);
  };

  return (
    <S.Container>
      {/* <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=405&height=141" /> */}
      <S.Content>
        <S.ProductList>
          {Object.keys(data.products)
            .sort((a, b) => {
              return +data.products[a].order - +data.products[b].order;
            })
            .map((item) => (
              <S.Product key={item} onClick={() => handleSelectProduct(item)}>
                <S.ProductImage
                  src={`http://189.127.164.125/babilonia/gb_inventory/${ item.split('|')[0] }.png`}
                />
                <S.ProductTitle>{data.products[item].name}</S.ProductTitle>
              </S.Product>
            ))}
        </S.ProductList>
        <S.ProductMaterials>
          {product.name ? (
            <S.Form>
              <S.Title>{data.title}</S.Title>
              <S.HeaderProduction className="p-item">
                <S.ProductionImage
                  src={`http://189.127.164.125/babilonia/gb_inventory/${ productIndex.split('|')[0] }.png`}
                />
                <S.Description>
                  <S.ProductionTitle>{product.name}</S.ProductionTitle>
                  <S.QtdPerProduction>{amount} unidade(s)</S.QtdPerProduction>
                </S.Description>
              </S.HeaderProduction>
              <S.Materials>
                {Object.keys(product.materials).map((item) => (
                  <S.HeaderProduction key={item}>
                    <S.ProductionImage
                      src={`http://189.127.164.125/babilonia/gb_inventory/${item}.png`}
                    />
                    <S.Description>
                      <S.ProductionTitle>
                        {product.materials[item].name}
                      </S.ProductionTitle>
                      <S.QtdPerProduction>
                        {product.materials[item].amount} unidade(s)
                      </S.QtdPerProduction>
                    </S.Description>
                  </S.HeaderProduction>
                ))}
              </S.Materials>
              <S.Actions>
                <Input
                  type="number"
                  label="Quantidade:"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                />
                <S.Button onClick={handleProduction} disabled={blockProduction}>
                  Produzir
                </S.Button>
              </S.Actions>
            </S.Form>
          ) : (
            <S.EmptyProduct>Selecione um produto para produzir!</S.EmptyProduct>
          )}
        </S.ProductMaterials>
      </S.Content>
    </S.Container>
  );
}

export default Production;
