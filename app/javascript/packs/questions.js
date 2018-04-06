import TurbolinksAdapter from "vue-turbolinks";
import axios from "axios";
import BootstrapVue from "bootstrap-vue";
import Vue from "vue/dist/vue.esm";
import Voting from "../components/question/voting.vue";
import Subscription from "../components/question/subsciption.vue";

Vue.use(axios);
Vue.use(BootstrapVue);
Vue.use(TurbolinksAdapter);

document.addEventListener("turbolinks:load", () => {
  const app = new Vue({
    el: "#question",
    components: { Voting, Subscription }
  });
});
