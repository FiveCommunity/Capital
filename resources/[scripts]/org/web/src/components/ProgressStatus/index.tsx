import { useMemo, useState } from "react";
import { GoalsDTO, MemberGoalDTO } from "../../DTOS/Goals";
import * as S from "./styles";

type ProgressStatusProps = {
  userGoals: MemberGoalDTO[];
  goals: GoalsDTO[];
};

const ProgressStatus = ({ goals, userGoals }: ProgressStatusProps) => {
  const [dropdown, setDropdown] = useState(false);

  const percentGoals = useMemo(() => {
    let totalGoal = 0;
    let totalUserGoal = 0;

    goals.map((goal) => {
      totalGoal += goal.qtd;
    });

    let currentGoalsCount: { item: string; qtd: number }[] = [];

    userGoals.map((item) => {
      const currentGoal = goals.filter(
        (goal) => goal.product_index === item.product
      );
      const currentProd = currentGoalsCount.filter(
        (prod) => prod.item === item.product
      );
      if (currentGoal.length > 0) {
        if (currentProd.length > 0) {
          currentGoalsCount = currentGoalsCount.map((prod) => {
            if (prod.item === item.product) {
              return {
                item: item.product,
                qtd:
                  item.qtd + prod.qtd > currentGoal[0].qtd
                    ? currentGoal[0].qtd
                    : item.qtd + prod.qtd,
              };
            } else {
              return prod;
            }
          });
        } else {
          currentGoalsCount.push({
            item: item.product,
            qtd: item.qtd > currentGoal[0].qtd ? currentGoal[0].qtd : item.qtd,
          });
        }
      }
    });

    let total = 0;

    currentGoalsCount.map((prod) => {
      total += prod.qtd;
    });

    return `${Math.round((total / totalGoal) * 100)}%`;
  }, [userGoals, goals]);

  const getTotalUserGoals = (product: string) => {
    let total = 0;
    userGoals
      .filter((item) => item.product === product)
      .map((currentProduct) => {
        total += currentProduct.qtd;
      });
    return total;
  };

  return (
    <S.Progress
      onMouseOver={() => setDropdown(true)}
      onMouseOut={() => setDropdown(false)}
    >
      <S.ProgressIndicator percentWidth={percentGoals} />
      <S.ProgressLabel>{percentGoals}</S.ProgressLabel>
      {dropdown && (
        <S.ProgressDetails>
          {goals.map((item) => (
            <S.ProgressDetailsItem key={item.product}>
              <b>{item.product}</b>
              <small>
                <>
                  {getTotalUserGoals(item.product_index)}/{item.qtd}
                </>
              </small>
            </S.ProgressDetailsItem>
          ))}
        </S.ProgressDetails>
      )}
    </S.Progress>
  );
};

export default ProgressStatus;
