import React, { ReactNode, createContext, useState } from "react";

type PermissionsRolesType = {
  full_permissions: string | string[];
  half_permissions: string | string[];
};

export type UserType = {
  user_id: number;
  fac: string;
  fac_type: string;
  permissions_roles: PermissionsRolesType;
  has_products: boolean;
  role: string;
};

type UserContextType = {
  user: UserType;
  setUser: (value: UserType) => void;
};

export const UserContext = createContext<UserContextType>(
  {} as UserContextType
);

const UserContextProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<UserType>({} as UserType);

  return (
    <UserContext.Provider value={{ user, setUser }}>
      {children}
    </UserContext.Provider>
  );
};

export default UserContextProvider;
