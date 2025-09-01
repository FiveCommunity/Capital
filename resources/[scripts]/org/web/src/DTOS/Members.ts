export interface MemberDTO {
  user_id: number;
  name: string;
  rg: string;
  role: string;
  phone: string;
  age: string;
  status: string;
  fac: string;
  isJob: boolean;
}

export interface MembersAmountDTO {
  vagas: number;
  amount: number;
}

export interface UserDetailsDTO {
  last_seen: string;
  hours_worked: string;
  hours_worked_week: string;
}
