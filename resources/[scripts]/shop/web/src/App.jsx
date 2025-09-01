import * as S from "./styles";

import { useState, useMemo, useEffect, useCallback } from "react";

import { MdOutlineSearch, MdCancel, MdCheckCircle } from "react-icons/md";
import { LuWallet2 } from "react-icons/lu";
import { FaShoppingCart } from "react-icons/fa";
import { RiVipDiamondFill } from "react-icons/ri";

import { useRequest } from "./hooks/useRequest";

function App({ theme }) {
  const { request } = useRequest();
  const [shop, setShop] = useState({
    show: false,
    items: [{ name: "" }],
  });
  const [search, setSearch] = useState("");
  const [subMenu, setSubMenu] = useState(false);
  const [confirmed, setConfirmed] = useState(false);
  const [amount, setAmount] = useState(1);
  const [itemSelected, setItemSelected] = useState({});

  const CurrencyFormatter = new Intl.NumberFormat("pt-BR", {
    style: "currency",
    currency: "BRL",
  });

  const filteredsItems = useMemo(() => {
    return shop.items.filter((item) =>
      item.name.toLowerCase().includes(search.toLowerCase())
    );
  }, [shop, search]);

  useEffect(() => {
    setAmount(1);
  }, [itemSelected]);

  useEffect(() => {
    if (amount <= 0 || isNaN(amount)) {
      setAmount(1);
      setConfirmed(false);
    } else {
      setConfirmed(true);
    }
  }, [amount]);

  const actions = {
    shop: ({ data }) => setShop(data),
    wallet: ({ wallet }) => setShop((old) => ({ ...old, wallet: wallet })),
  };

  const nuiMessage = useCallback((event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  const handleReady = useCallback(async () => {
    await request("NuiReady");
  }, [request]);

  useEffect(() => {
    handleReady();
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        request("close");
        setShop({ show: false, items: [{ name: "" }] });
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request]);

  const handleBuy = () => {
    request("Checkout", {
      item: itemSelected.index,
      type: itemSelected.type,
      price: itemSelected.price * amount,
      method: itemSelected.method,
      amount: amount,
    });

    setItemSelected({});
    setSubMenu(false);
  };

  const openSubMenu = (item, type) => {
    setSubMenu(true);
    setItemSelected({
      name: item.name,
      index: item.index,
      price: { buy: item.price.buy, sell: item.price.sell },
      method: item.method,
      type: type,
      desc: item.description,
    });
  };

  return (
    <>
      <S.GlobalStyle />
      {shop.show && (
        <S.Wrap>
          <S.Container>
            <S.Header>
              <S.ShopName>
                <FaShoppingCart style={{ color: shop.shopColor }} />
                <h1>{shop.name}</h1>
              </S.ShopName>
              <S.Search>
                <S.Input
                  type="text"
                  placeholder="Pesquisa..."
                  onChange={(e) => setSearch(e.target.value)}
                />
                <S.Submit type="submit" style={{ pointerEvents: "none" }}>
                  <MdOutlineSearch
                    style={{
                      color: shop.shopColor,
                    }}
                  />
                </S.Submit>
              </S.Search>
              <S.Wallet>
                {(shop.coins !== false && (
                  <>
                    <RiVipDiamondFill style={{ color: "#00ecffcc" }} />
                    <span>{shop.coins}</span>
                  </>
                )) || (
                  <>
                    <LuWallet2 />
                    <span>{CurrencyFormatter.format(shop.wallet)}</span>
                  </>
                )}
              </S.Wallet>
            </S.Header>
            <S.Main
              style={{
                opacity: subMenu ? "0.3" : "1.0",
              }}
            >
              <S.WrapItem>
                {filteredsItems.length > 0 ? (
                  <>
                    {filteredsItems.map((item, index) => (
                      <S.Items key={index} id={index}>
                        <S.ItemHeader>
                          <h2>{item.name}</h2>
                          <span style={{ color: shop.shopColor }}>
                            {(shop.coins !== false && (
                              <>
                                {shop.type === "sell"
                                  ? item.price.sell
                                  : item.price.buy}
                              </>
                            )) || (
                              <>
                                {shop.type === "sell"
                                  ? CurrencyFormatter.format(item.price.sell)
                                  : CurrencyFormatter.format(item.price.buy)}
                              </>
                            )}
                          </span>
                        </S.ItemHeader>
                        <S.ItemImage>
                          <img
                            src={`http://189.127.164.125/babilonia/gb_inventory/${item.index}.png`}
                          />
                        </S.ItemImage>
                        <S.Footer>
                          {shop.type === "all" && (
                            <>
                              <S.ItemButton
                                style={{
                                  backgroundColor: shop.shopColor,
                                  color: theme.colors.shape(),
                                }}
                                onClick={() => openSubMenu(item, "buy")}
                              >
                                comprar
                              </S.ItemButton>
                              <S.ItemButton
                                onClick={() => openSubMenu(item, "sell")}
                              >
                                vender
                              </S.ItemButton>
                            </>
                          )}
                          {shop.type === "buy" && (
                            <S.ItemButton
                              style={{
                                backgroundColor: shop.shopColor,
                                color: theme.colors.shape(),
                              }}
                              onClick={() => openSubMenu(item, "buy")}
                            >
                              comprar
                            </S.ItemButton>
                          )}
                          {shop.type === "sell" && (
                            <S.ItemButton
                              onClick={() => openSubMenu(item, "sell")}
                            >
                              vender
                            </S.ItemButton>
                          )}
                          {item.description && (
                            <S.ItemButton
                              onClick={() => openSubMenu(item, "desc")}
                            >
                              detalhes
                            </S.ItemButton>
                          )}
                        </S.Footer>
                      </S.Items>
                    ))}
                  </>
                ) : (
                  <S.EmptyItems>Item não encontrado!</S.EmptyItems>
                )}
              </S.WrapItem>
            </S.Main>
            {subMenu && (
              <S.SubMenu>
                <S.SubContainer>
                  {(itemSelected.type === "desc" && (
                    <>
                      <p
                        style={{ color: "white" }}
                        dangerouslySetInnerHTML={{
                          __html: itemSelected.desc,
                        }}
                      />
                      <S.SubFooter>
                        <S.SubButton
                          style={{ backgroundColor: "rgb(255, 0, 0)" }}
                          onClick={() => {
                            setSubMenu(false);
                            setItemSelected({});
                          }}
                        >
                          <MdCancel />
                          fechar
                        </S.SubButton>
                      </S.SubFooter>
                    </>
                  )) || (
                    <>
                      <S.SubItemName>
                        <span>{itemSelected.name}</span>
                      </S.SubItemName>
                      <S.SubCenter>
                        <S.Sinal
                          onClick={() =>
                            setAmount((old) => {
                              if (old <= 1) {
                                return 1;
                              } else {
                                return (old -= 1);
                              }
                            })
                          }
                        >
                          -
                        </S.Sinal>
                        <S.SubItemImage>
                          <img
                            src={`http://189.127.164.125/babilonia/gb_inventory/${itemSelected.index}.png`}
                          />
                        </S.SubItemImage>
                        <S.Sinal onClick={() => setAmount((old) => (old += 1))}>
                          +
                        </S.Sinal>
                      </S.SubCenter>
                      <S.SubInput
                        type="number"
                        value={amount}
                        onChange={(e) => setAmount(parseInt(e.target.value))}
                      />
                      <S.SubValue>
                        <strong>valor:</strong>
                        <span style={{ color: shop.shopColor }}>
                          {(shop.coins !== false && (
                            <>
                              {itemSelected.type === "sell"
                                ? itemSelected.price.sell * amount
                                : itemSelected.price.buy * amount}
                            </>
                          )) || (
                            <>
                              {CurrencyFormatter.format(
                                itemSelected.type === "sell"
                                  ? itemSelected.price.sell * amount
                                  : itemSelected.price.buy * amount
                              )}
                            </>
                          )}
                        </span>
                      </S.SubValue>
                      <S.SubFooter>
                        <S.SubButton
                          style={{ backgroundColor: "rgb(255, 0, 0)" }}
                          onClick={() => {
                            setSubMenu(false);
                            setItemSelected({});
                          }}
                        >
                          <MdCancel />
                          cancelar
                        </S.SubButton>
                        <S.SubButton
                          style={{
                            backgroundColor: "rgb(60, 179, 113)",
                            opacity: confirmed ? "1.0" : "0.5",
                            pointerEvents: confirmed ? "" : "none",
                          }}
                          onClick={() => handleBuy()}
                        >
                          <MdCheckCircle />
                          confirmar
                        </S.SubButton>
                      </S.SubFooter>
                    </>
                  )}
                </S.SubContainer>
              </S.SubMenu>
            )}
          </S.Container>
        </S.Wrap>
      )}
    </>
  );
}

export default App;
