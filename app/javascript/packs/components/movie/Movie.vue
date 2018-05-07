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
                <p><strong>Rating: </strong> <i v-if="vote">Your rating: {{ vote }}</i></p>
                <app-star-rating
                        :increment="0.5"
                        :max-rating="10"
                        :rating="parseInt(rating)"
                        :read-only="!isLogged || isVoted"
                        @rating-selected="setRating"
                        inactive-color="#000"
                        active-color="#cc1166"
                        :star-size="32"
                > 5
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
    data() {
      return {
        isVoted: false,
        vote: null
      }
    },
    computed: {
      ...mapGetters({
        loading: 'movie/loading',
        movie: 'movie/item',
        rating: 'movie/rating',
        isLogged: 'authentication/isLogged',
        userId: 'authentication/userId'
      })
    },
    methods: {
      setRating: function (rating) {
        this.$store.dispatch('movie/rateMovie', {id: this.movie.id, rating}).then(() => {
          this.isVoted = true;
          this.vote = rating;
        })
      },
      checkVoted: function () {
        const vote = this.movie.rating.filter(vote => {
          return vote.user_id === this.userId;
        });
        this.isVoted = !!vote.length;
        this.vote = null;
        if (vote.length) {
          this.vote = vote[0].rating;
        }
      }
    },
    created() {
      this.$store.dispatch('movie/loadMovie', this.$route.params.id)
        .then(() => {
          this.checkVoted();
        });
    },
    components: {
      appActor: Actor,
      appComment: Comment,
      appCommentForm: CommentForm,
      appStarRating: StarRating
    }
  }
</script>