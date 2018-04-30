import api from "../../api";

const state = {
  loading: false
};

const getters = {
  loading(state) {
    return state.loading;
  }
};

const mutations = {
  SET_LOADING(state, loading) {
    state.loading = loading;
  }
};

const actions = {
  addComment({commit}, payload) {
    commit("SET_LOADING", true);
    return api.comments
      .addComment(payload)
      .then(data => {
        console.log(data);
      })
      .catch(() => {
        console.log("test");
      })
      .finally(() => {
        commit("SET_LOADING", false);
      });
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions
};
