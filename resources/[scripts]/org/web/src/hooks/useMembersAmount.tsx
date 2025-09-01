import { useState, useContext } from "react";
import { UserContext } from "../contexts/UserContext";
import { MembersAmountDTO } from "../DTOS/Members";
import api from "../services/api";

const useMembersAmount = () => {
  const { user } = useContext(UserContext);
  const [membersAmount, setMembersAmount] = useState<MembersAmountDTO>(
    {} as MembersAmountDTO
  );

  const getMembersAmount = async () => {
    const response = JSON.parse(
      (
        await api.post(
          "/getMembersAmount",
          JSON.stringify({
            fac: user.fac,
          })
        )
      ).data
    );
    setMembersAmount(response);
  };
  return {
    membersAmount,
    setMembersAmount,
    getMembersAmount,
  };
};

export default useMembersAmount;
