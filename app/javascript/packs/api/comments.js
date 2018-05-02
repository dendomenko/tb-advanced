import Vue from "vue/dist/vue.esm";
import store from "../store/store";

export const addComment = (payload) =>
  new Promise((resolve, reject) => {
    Vue.http
      .post("comments", {
        text: payload.text,
        commentable_type: payload.commentable_type,
        commentable_id: payload.commentable_id
      }, {
        headers: {
          Authorization: `Bearer: ${store.getters["authentication/authToken"]}`
        }
      })
      .then(response => {
        const data = response.data;
        // console.log(data);
        return resolve({
          data
        });
      })
      .catch(error => {
        console.log(error);
        return reject(error);
      });
  });
