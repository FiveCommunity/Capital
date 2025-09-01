import Tablet from "./components/Tablet";
import Wrapper from "./components/Wrapper";
import NuiContextProvider from "./contexts/NuiContext";
import { PagesProvider } from "./contexts/PagesContext";
import UserContextProvider from "./contexts/UserContext";
import { GlobalStyle } from "./styles";
import GoalsSenderContextProvider from "./contexts/GoalsSenderContext";
import "react-toastify/dist/ReactToastify.css";

const App = () => {
  return (
    <PagesProvider>
      <GoalsSenderContextProvider>
        <NuiContextProvider>
          <UserContextProvider>
            <GlobalStyle />
            <Wrapper />
          </UserContextProvider>
        </NuiContextProvider>
      </GoalsSenderContextProvider>
    </PagesProvider>
  );
};

export default App;
