import SignIn from "./components/authentication/SignIn.vue";
import SignUp from "./components/authentication/SignUp.vue";
import Home from "./components/Home.vue";

export const routes = [
  { path: "/user/signin", component: SignIn },
  { path: "/user/signup", component: SignUp },
  { path: "/", component: Home }
  // { path: '/portfolio', component: Portfolio },
  // { path: '/stocks', component: Stocks },
];
