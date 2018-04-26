import Vue from "vue/dist/vue.esm";
import Vuex from "vuex";

import authentication from "./modules/authentication";
import error from "./modules/error";
import movies from "./modules/movies";
import movie from "./modules/movie";
import news from "./modules/news";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    error,
    authentication,
    movies,
    movie,
    news
  }
});
