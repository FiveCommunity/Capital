import { useContext } from "react";
import * as S from "./styles";
import PagesContext from "../../contexts/PagesContext";
import { UserContext } from "../../contexts/UserContext";
import LogoFac from "../../assets/logo_fac.png";
import LogoJob from "../../assets/logo_job.png";

const logos = {
  fac: LogoFac,
  job: LogoJob,
};

const Login = () => {
  const { setCurrentPage } = useContext(PagesContext);
  const { user } = useContext(UserContext);

  return (
    <S.Container facType={user.fac_type as any}>
      <S.Filter>
        <S.BtnLogin onClick={() => setCurrentPage("membros")}>
          <S.WrapLogo>
            <S.Logo src={logos[user.fac_type as `fac` | `job`]} />
          </S.WrapLogo>
          <S.Title>{user.fac}</S.Title>
        </S.BtnLogin>
      </S.Filter>
    </S.Container>
  );
};

export default Login;
