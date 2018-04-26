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

export const signUp = id =>
  new Promise((resolve, reject) => {
    Vue.http
      .get(`news/${id}`)
      .then(response => {
        const data = response.data;
        const newsItem = toNews(data, true);
        return resolve(newsItem);
      })
      .catch(error => reject(error));
  });