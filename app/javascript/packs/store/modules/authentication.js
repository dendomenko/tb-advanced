import Vue from "vue/dist/vue.esm";

const state = {
  isLogged: false,
  authToken: ""
};

const mutations = {
  'SIGN_IN'(state, { email, password }) {
    Vue.http
      .post("auth_user", { email, password })
      .then(response => {
        // response.json();
        state.isLogged = true;
        state.authToken = response.data.auth_token;
        Vue.localStorage.set("authToken", state.authToken);
      })
      .catch(error => {
        rootState.errors.errorState = error.body.errors[0];
        console.log(error.body.errors[0]);
      });
  },
  'SIGN_OUT'(state) {
    state.isLogged = false;
    Vue.localStorage.set("authToken", null);
  }
};

const actions = {
  signIn: ({ commit }, user) => {
    commit("SIGN_IN", user);
  },
  signOut: ({ commit }) => {
    commit("SIGN_OUT");
  }
};

const getters = {
  isLogged: state => state.isLogged,
  isError: state => state.authToken
};

export default {
  state,
  mutations,
  actions,
  getters
};
