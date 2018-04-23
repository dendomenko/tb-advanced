import SignIn from "./components/authentication/SignIn.vue";
import SignUp from "./components/authentication/SignUp.vue";
import Home from "./components/Home.vue";
import Movies from "./components/movie/Movies.vue";
import Movie from "./components/movie/Movie.vue";

export const routes = [
  { path: "/user/signin", component: SignIn },
  { path: "/user/signup", component: SignUp },
  { path: "/", component: Home },
  { path: "/movies", component: Movies },
  { path: "/movies/:id", name: "movie", component: Movie }
];
