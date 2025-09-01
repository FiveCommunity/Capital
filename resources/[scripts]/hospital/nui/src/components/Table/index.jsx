import { useContext, useEffect, useMemo, useRef, useState } from "react";
import * as S from "./styles";
import { BiMessageDetail } from "react-icons/bi";
import { FaChevronLeft, FaChevronRight } from "react-icons/fa";
import PainelContext from "../../contexts/PainelContext";
import useRequest from "../../hooks/useRequest";
import FilterContext from "../../contexts/FilterContext";

function Table({
  headRow,
  rowIndexes,
  data,
  search,
  detail = false,
  handleShowDetail,
}) {
  const { painel } = useContext(PainelContext);
  const { filter } = useContext(FilterContext);
  const { request } = useRequest();

  const servicesAmount = useMemo(() => {
    return Math.ceil(+painel.servicesAmount / 7);
  }, [painel]);

  const handleChangePage = (method) => {
    if (method === "up") {
      request("changeFilter", {
        ...filter,
        page: +filter.page + 1,
      });
    } else {
      request("changeFilter", {
        ...filter,
        page: +filter.page - 1,
      });
    }
  };

  const formattedData = useMemo(() => {
    let formattedItems = [];

    data.map((row) => {
      formattedItems = [
        ...formattedItems,
        rowIndexes.map((item) => {
          return row[item];
        }),
      ];
    });

    return formattedItems;
  }, [data, rowIndexes]);

  return (
    <S.WrapTable>
      <S.Table>
        <S.Row className="head">
          {headRow.map((item) => (
            <S.Td key={item.title}>
              {item.icon} {item.title}
            </S.Td>
          ))}
          {detail && <S.Td className="detail"></S.Td>}
        </S.Row>
        {formattedData.length > 0 ? (
          <>
            {formattedData.map((row, index) => (
              <S.Row key={index}>
                {row.map((column) => (
                  <S.Td key={index}>{column}</S.Td>
                ))}
                {detail && (
                  <S.Td className="detail">
                    <S.ButtonAction
                      onClick={() => handleShowDetail(data[index])}
                    >
                      <BiMessageDetail />
                    </S.ButtonAction>
                  </S.Td>
                )}
              </S.Row>
            ))}
          </>
        ) : (
          <S.EmptyFeedback>Nenhum serviço foi encontrado.</S.EmptyFeedback>
        )}
      </S.Table>
      {((servicesAmount !== 1 && servicesAmount !== 0) ||
        filter.page !== 1) && (
        <S.Pagination>
          {filter.page !== 1 && (
            <S.ButtonPagination onClick={() => handleChangePage("down")}>
              <FaChevronLeft />
            </S.ButtonPagination>
          )}
          <S.IndicatorPagination>
            {filter.page} / {servicesAmount}
          </S.IndicatorPagination>
          {filter.page !== servicesAmount && (
            <S.ButtonPagination onClick={() => handleChangePage("up")}>
              <FaChevronRight />
            </S.ButtonPagination>
          )}
        </S.Pagination>
      )}
    </S.WrapTable>
  );
}

export default Table;
