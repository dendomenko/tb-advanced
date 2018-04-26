const state = {
  errorText: "",
  show: false
};

const getters = {
  errorText(state) {
    return state.errorText;
  },
  show(state) {
    return state.show;
  }
};

const mutations = {
  SET_ERROR(state, error) {
    state.errorText = error;
    state.show = true;
  },
  CLEAN_ERROR(state) {
    state.errorText = "";
    state.show = false;
  }
};

const actions = {
  showError({ commit }, error) {
    commit("SET_ERROR", error);
  },
  cleanError({ commit }) {
    commit("CLEAN_ERROR");
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
};
