const state = {
  errorText: ""
};

const mutations = {
  CLEAN_ERROR(state) {
    state.errorText = "";
  }
};

const actions = {
  cleanErrors: ({ commit }) => {
    commit("CLEAN_ERROR");
  }
};

const getters = {
  getErrorText: state => state.errorText
};

export default {
  state,
  mutations,
  actions,
  getters
};
