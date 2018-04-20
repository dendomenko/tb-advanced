import Vue from "vue/dist/vue.esm";
import Vuex from "vuex";

import authentication from "./modules/authentication";
import error from "./modules/error";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    error,
    authentication
  }
});
