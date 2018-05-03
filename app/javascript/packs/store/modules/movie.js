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
  },
  APPEND_COMMENT(state, comment) {
    state.item.comments.push(comment);
  }
};

const actions = {
  loadMovie({commit}, id) {
    commit("SET_LOADING", true);
    return api.movies
      .getMovie(id)
      .then(data => {
        commit("SET_MOVIE", data);
      })
      .catch(() => {
        commit("SET_MOVIE", {});
      })
      .finally(() => {
        commit("SET_LOADING", false);
      });
  },
  rateMovie({commit}, { id, rating }) {
    return api.movies.rateMovie(id, rating).then(data => data);
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions
};
