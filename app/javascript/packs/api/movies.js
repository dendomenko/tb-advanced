import Vue from "vue/dist/vue.esm";

const toMovie = (item, full) => {
  const movie = {
    id: item.id,
    title: item.title,
    description: item.description,
    year: item.year
  };
  if (full) {
    movie.actors = item.actors;
    movie.directors = item.directors;
  }
  return movie;
};

export const index = () =>
  new Promise((resolve, reject) => {
    Vue.http
      .get("movies/")
      .then(response => {
        const data = response.data;
        const movies = [];
        data.forEach(item => {
          // console.log(item);
          movies.push(toMovie(item, false));
        });
        return resolve({movies});
      })
      .catch(error => reject(error));
  });

export const getMovie = id =>
  new Promise((resolve, reject) => {
    Vue.http
      .get(`movies/${id}`)
      .then(response => {
        const data = response.data;
        console.log(data);
        const movie = toMovie(data, true);
        return resolve(movie);
      })
      .catch(error => reject(error));
  });