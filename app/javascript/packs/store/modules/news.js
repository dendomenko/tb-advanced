import api from "../../api";

const state = {
  list: [],
  loading: false
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
  SET_NEWS(state, data) {
    state.list = data.news;
  }
};

const actions = {
  loadNews: ({ commit }) => {
    commit("SET_LOADING", true);
    return api.news
      .index()
      .then(data => {
        commit("SET_NEWS", data);
      })
      .catch(() => {
        commit("SET_NEWS", { news: [] });
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
  actions,
  getters
};
