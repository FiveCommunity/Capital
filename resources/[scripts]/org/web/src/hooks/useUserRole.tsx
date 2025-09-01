import { useContext } from "react";
import { UserContext } from "../contexts/UserContext";

const useUserRole = () => {
  const { user } = useContext(UserContext);

  const getPermission = () => {
    if (user.permissions_roles.full_permissions.includes(user.role))
      return "Lider";
    else if (user.permissions_roles.half_permissions.includes(user.role))
      return "ViceLider";
    else return "Membro";
  };

  return {
    getPermission,
  };
};

export default useUserRole;
