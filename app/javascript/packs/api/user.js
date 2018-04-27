import Vue from "vue/dist/vue.esm";

export const signIn = (payload) =>
  new Promise((resolve, reject) => {
    Vue.http
      .post("auth_user", { email: payload.email, password: payload.password })
      .then(response => {
        const data = response.data;
        return resolve({
          authToken: data.auth_token,
          userId: data.user.id
        });
      })
      .catch(error => reject(error));
  });

export const signUp = (payload) =>
  new Promise((resolve, reject) => {
    Vue.http
      .post("sign_up", {
        email: payload.email,
        password: payload.password,
        password_confirmation: payload.password_confirmation
      })
      .then(response => {
        const data = response.data;
        return resolve({
          authToken: data.auth_token,
          userId: data.user.id
        });
      })
      .catch(error => reject(error));
  });