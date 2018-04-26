<template>
    <div class="row">
        <div class="container">
            <h1>{{ movie.title}}({{ movie.year | moment("YYYY") }})</h1>
            <p>{{ movie.description }}</p>
            <p></p>
            <div v-for="actor in movie.actors">
                <app-actor :actor="actor"></app-actor>
            </div>
        </div>
    </div>
</template>

<script>
  import Actor from "./Actor.vue";
  import {mapGetters} from 'vuex';

  export default {
    computed: {
      ...mapGetters({
        loading: 'movie/loading',
        movie: 'movie/item'
      })
    },
    created() {
      this.$store.dispatch('movie/loadMovie', this.$route.params.id);
      //
      // Vue.http.get('movies/' + this.$route.params.id)
      //   .then(response => {
      //     this.movie = response.data;
      //   });
    },
    components: {
      appActor: Actor
    }
  }
</script>