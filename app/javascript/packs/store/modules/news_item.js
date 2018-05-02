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
  SET_NEWS_ITEM(state, data) {
    state.item = data;
  },
  APPEND_COMMENT(state, comment) {
    state.item.comments.push(comment);
  }
};

const actions = {
  loadNewsItem({commit}, id) {
    commit("SET_LOADING", true);
    return api.news
      .getNewsItem(id)
      .then(data => {
        commit("SET_NEWS_ITEM", data);
      })
      .catch(() => {
        commit("SET_NEWS_ITEM", {});
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
