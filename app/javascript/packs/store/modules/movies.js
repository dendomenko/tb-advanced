import api from "../../api";

const state = {
  loading: false,
  list: []
};

const getters = {
  loading(state) {
    return state.loading;
  },
  list(state) {
    return state.list;
  }
};

const mutations = {
  SET_LOADING(state, loading) {
    state.loading = loading;
  },
  SET_MOVIES(state, data) {
    state.list = data.movies;
  }
};

const actions = {
  loadMovies({ commit }) {
    commit("SET_LOADING", true);
    return api.movies
      .index()
      .then(data => {
        commit("SET_MOVIES", data);
      })
      .catch(() => {
        commit("SET_MOVIES", {
          movies: []
        });
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
