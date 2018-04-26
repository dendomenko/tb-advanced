import Vue from "vue/dist/vue.esm";

const toNews = (item) => {
  const newsItem = {
    id: item.id,
    title: item.title,
    description: item.description
  };
  return newsItem;
};

export const index = () =>
  new Promise((resolve, reject) => {
    Vue.http
      .get("news/")
      .then(response => {
        const data = response.data;
        const news = [];
        data.forEach(item => {
          news.push(toNews(item, false));
        });
        return resolve({news});
      })
      .catch(error => reject(error));
  });

export const getNewsItem = id =>
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
