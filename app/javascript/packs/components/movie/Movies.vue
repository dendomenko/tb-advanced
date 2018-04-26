<template>
    <div>
        <div class="row">
            <div class="container">
                <b-card-group>
                    <b-card v-for="(movie, id) in movies"
                            :title="movie.title"
                            img-src="https://lorempixel.com/600/300/food/5/"
                            img-alt="Image"
                            img-top
                            tag="article"
                            style="max-width: 20rem;"
                            class="mb-2">
                        <p class="card-text">
                            {{ movie.description }}
                        </p>
                        <router-link :to="{name: 'movie', params: { id: movie.id } }">More...</router-link>
                    </b-card>
                </b-card-group>
            </div>
        </div>
    </div>
</template>

<script>
  import { mapGetters } from 'vuex';

  export default {
    computed: {
      ...mapGetters({
        loading: 'movies/loading',
        movies: 'movies/list'
      })
    },
    created() {
        this.$store.dispatch('movies/loadMovies');
    }
  }
</script>