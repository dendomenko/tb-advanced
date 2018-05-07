import api from "../../api";

const state = {
  loading: false,
  item: {},
  rating: 0
};

const getters = {
  loading(state) {
    return state.loading;
  },
  item(state) {
    return state.item;
  },
  rating(state) {
    return state.rating;
  }
};

const mutations = {
  SET_LOADING(state, loading) {
    state.loading = loading;
  },
  SET_MOVIE(state, data) {
    state.item = data;
    if (data.rating.length) {
      state.rating = data.rating.reduce(function (prev, curr) {
        return prev + parseFloat(curr.rating);
      }, 0) / data.rating.length;
    } else {
      state.rating = 0;
    }
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
  rateMovie({commit}, {id, rating}) {
    return api.movies
      .rateMovie(id, rating)
      .then(data => {
        commit("SET_MOVIE", data);
      })
      .catch(error => {
        commit("error/SET_ERROR", error.body.error, { root: true });
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
