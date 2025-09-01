import Header from "../Header";
import Table from "../Table";
import * as S from "./styles";

import { PiIdentificationBadge } from "react-icons/pi";
import { MdMan2 } from "react-icons/md";
import { CiMedicalCross } from "react-icons/ci";
import { BiDollar } from "react-icons/bi";
import { useContext, useMemo } from "react";
import Details from "../Details";
import PainelContext from "../../contexts/PainelContext";
import { formatDate, intToReal } from "../../utils";
import DetailsContext from "../../contexts/DetailsContext";

function Painel() {
  const { painel } = useContext(PainelContext);
  const { setDetails } = useContext(DetailsContext);

  const renderServices = useMemo(() => {
    let newServices = painel.services.map((item) => ({
      ...item,
      total_price: intToReal(item.total_price) ?? item.total_price,
      service_date: formatDate(new Date(item.service_date)),
    }));

    return newServices;
  }, [painel]);

  return (
    <S.Container>
      {/* <S.BackgroundImage src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=994&height=346" /> */}
      <S.Content>
        <Details />
        <Header />
        <S.Body>
          <Table
            headRow={[
              { icon: <MdMan2 />, title: "Paciente" },
              { icon: <CiMedicalCross />, title: "Médico" },
              { icon: <BiDollar />, title: "Valor" },
              { icon: <PiIdentificationBadge />, title: "Data" },
            ]}
            detail={true}
            rowIndexes={[
              "patient_name",
              "doctor_name",
              "total_price",
              "service_date",
            ]}
            data={renderServices}
            handleShowDetail={(data) => setDetails(data)}
          />
        </S.Body>
      </S.Content>
    </S.Container>
  );
}

export default Painel;
