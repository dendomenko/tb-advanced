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
    return api.comments // TODO: find a more beautiful solution
      .addComment(payload)
      .then(response => {
        switch (payload.commentable_type) {
          case "Movie":
            commit("movie/APPEND_COMMENT", response.data, {root: true});
            break;
          case "News":
            commit("news_item/APPEND_COMMENT", response.data, {root: true});
            break;
          default:
            break;
        }
      })
      .catch((error) => {
        console.log(error);
      })
      .finally(() => {
        commit("SET_LOADING", false);
      });
  },
  deleteComment({commit}, id) {
    return api.comments.deleteComment(id);
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions
};
