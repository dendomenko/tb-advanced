<template>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">{{ movie.title}}({{ movie.year | moment("YYYY") }})</h1>
            </div>
            <p>{{ movie.description }}</p>
            <p></p>
            <div class="col-md-12">
                <strong>Cast:</strong>
                <app-actor v-for="actor in movie.actors" :actor="actor"></app-actor>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <strong>Rating:</strong>
                <app-star-rating
                        :increment="0.5"
                        :max-rating="10"
                        :rating="parseInt(movie.rating)"
                        :read-only="!isLogged"
                        @rating-selected ="setRating"
                        inactive-color="#000"
                        active-color="#cc1166"
                        :star-size="32"
                >
                </app-star-rating>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <strong class="text-center">Comments:</strong>
                <app-comment v-for="comment in movie.comments" :comment="comment"></app-comment>
            </div>
        </div>
        <div class="row">
            <app-comment-form commentable-type="Movie"></app-comment-form>
        </div>
    </div>
</template>

<script>
  import Actor from "./Actor.vue";
  import Comment from "../comment/Comment.vue";
  import CommentForm from "../comment/CommentForm.vue";
  import StarRating from 'vue-star-rating'
  import {mapGetters} from 'vuex';

  export default {
    computed: {
      ...mapGetters({
        loading: 'movie/loading',
        movie: 'movie/item',
        isLogged: 'authentication/isLogged'
      })
    },
    methods: {
      setRating: function(rating){
        console.log('in set rating');
        this.$store.dispatch('movie/rateMovie', { id: this.movie.id, rating }).then((response) => {
          console.log(response);
          this.movie.rating = parseInt(response);
        })
      }
    },
    created() {
      this.$store.dispatch('movie/loadMovie', this.$route.params.id);
    },
    components: {
      appActor: Actor,
      appComment: Comment,
      appCommentForm: CommentForm,
      appStarRating: StarRating
    }
  }
</script>