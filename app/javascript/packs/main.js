import Vue from "vue/dist/vue.esm";
import VueRouter from "vue-router";
import VueLocalStorage from "vue-localstorage";
import VueResource from "vue-resource";
import TurbolinksAdapter from "vue-turbolinks";
import BootstrapVue from "bootstrap-vue";

import App from "./App.vue";
import { routes } from "./routes";
import store from "./store/store";

Vue.use(VueResource);
Vue.use(VueRouter);
Vue.use(BootstrapVue);
Vue.use(VueLocalStorage);
Vue.use(TurbolinksAdapter);
Vue.use(require('vue-moment'));

Vue.http.options.root = "http://localhost:3000/api/v2/";

const router = new VueRouter({
  mode: "history",
  routes
});

document.addEventListener("turbolinks:load", () => {
  new Vue({
    el: "#app",
    router,
    store,
    render: h => h(App)
  });
});
