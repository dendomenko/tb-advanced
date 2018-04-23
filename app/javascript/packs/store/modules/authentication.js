import Vue from "vue/dist/vue.esm";

const state = {
  isLogged: false,
  authToken: null,
  userId: null
};

const mutations = {
  'SIGN_IN'(state, { email, password }) {
    Vue.http
      .post("auth_user", { email, password })
      .then(response => {
        // response.json();
        state.isLogged = true;
        state.authToken = response.data.auth_token;
        state.userId = response.data.user.id;
        Vue.localStorage.set("authToken", state.authToken);
        Vue.localStorage.set("userId", state.userId);
      })
      .catch(error => {
        console.log(error.body.errors[0]);
      });
  },
  'SIGN_OUT'(state) {
    state.isLogged = false;
    state.userId = null;
    state.authToken = null;

    Vue.localStorage.set("authToken", null);
    Vue.localStorage.set("userId", null);
  },
  'SIGN_UP'(state, { email, password }) {
    console.log('Should be implemented');
  }
};

const actions = {
  signIn: ({ commit }, user) => {
    commit("SIGN_IN", user);
  },
  signOut: ({ commit }) => {
    commit("SIGN_OUT");
  },
  signUp: ({ commit }, payload) => {
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
