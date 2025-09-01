import { MemberDTO } from "./Members";

export interface GoalsDTO {
  id: number;
  product: string;
  product_index: string;
  qtd: number;
  fac: string;
}

export interface ProductsDTO {
  name: string;
  index: string;
}

export interface ProductAndStorageDTO {
  storageWeightTotal: number;
  storageWeightFree: number;
  storage: {
    product: string;
    name: string;
    fac: string;
    qtd: number;
  }[];
  products: {
    index: string;
    name: string;
    weight: string;
  }[];
  fabricationProducts: {
    coastPerUnit: number;
    index: string;
    name: string;
    spawn: string;
    materials: {
      index: string;
      qtd: number;
    }[];
  }[];
}

export interface MemberGoalDTO {
  id: number;
  product: string;
  qtd: number;
  user_id: number;
  fac: string;
}

export interface MemberGoalsDTO extends MemberDTO {
  goals: MemberGoalDTO[];
}
