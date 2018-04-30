import Vue from "vue/dist/vue.esm";
import Vuex from "vuex";

import authentication from "./modules/authentication";
import error from "./modules/error";
import movies from "./modules/movies";
import movie from "./modules/movie";
import news from "./modules/news";
import news_item from "./modules/news_item";
import comments from "./modules/comments";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    error,
    authentication,
    movies,
    movie,
    news,
    news_item,
    comments
  }
});
