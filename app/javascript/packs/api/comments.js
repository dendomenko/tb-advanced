import Vue from "vue/dist/vue.esm";

export const addComment = (payload) =>
  new Promise((resolve, reject) => {
    Vue.http
      .post("comments", {
        text: payload.text,
        user_id: payload.userId,
        commentable_type: payload.commentable_type,
        commentable_id: payload.commentable_id
      })
      .then(response => {
        const data = response.data;
        console.log(data);
        return resolve({
          data
        });
      })
      .catch(error => {
        console.log(error);
        return reject(error);
      });
  });
