import api from "../../api";

const state = {
  isLogged: false,
  authToken: null,
  userId: null
};

const getters = {
  isLogged(state) {
    return state.isLogged;
  },
  authToken(state) {
    return state.authToken;
  },
  userId(state) {
    return state.userId;
  }
};

const mutations = {
  SIGN_IN(state, data) {
    console.log(data);
    state.isLogged = true;
    state.authToken = data.authToken;
    state.userId = data.userId;
  },
  SIGN_OUT(state) {
    state.isLogged = false;
    state.userId = null;
    state.authToken = null;
  },
  SIGN_UP(state, { email, password }) {
    console.log('Should be implemented');
  }
};

const actions = {
  signIn({commit}, data) {
    return api.user
      .signIn(data)
      .then(data => {
        commit("SIGN_IN", data);
        commit("error/CLEAN_ERROR", null, { root: true });
      })
      .catch((error) => {
        commit("error/SET_ERROR", error.body.error, { root: true });
      });
  },
  signOut: ({commit}) => {
    commit("SIGN_OUT");
  },
  signUp: ({commit}, payload) => {
    commit("SIGN_OUT");
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
};
