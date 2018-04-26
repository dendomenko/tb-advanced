import api from "../../api";

const state = {
  loading: false,
  item: {}
};

const getters = {
  loading(state) {
    return state.loading;
  },
  item(state) {
    return state.item;
  }
};

const mutations = {
  SET_LOADING(state, loading) {
    state.loading = loading;
  },
  SET_MOVIE(state, data) {
    state.item = data;
  }
};

const actions = {
  loadMovie({commit}, id) {
    commit("SET_LOADING", true);
    return api.movies
      .getMovie(id)
      .then(data => {
        console.log(data);
        commit("SET_MOVIE", data);
      })
      .catch(() => {
        commit("SET_MOVIE", {});
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
