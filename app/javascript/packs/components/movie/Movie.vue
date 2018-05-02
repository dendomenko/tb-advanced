<template>
    <div class="container">
        <div class="row">
            <h1>{{ movie.title}}({{ movie.year | moment("YYYY") }})</h1>
            <p>{{ movie.description }}</p>
            <p></p>
            <div v-for="actor in movie.actors">
                <app-actor :actor="actor"></app-actor>
            </div>
        </div>
        <div class="row">
            <strong class="text-center">Comments</strong>
            <div v-for="comment in movie.comments">
                <app-comment :comment="comment"></app-comment>
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
    },
    components: {
      appActor: Actor,
      appComment: Comment,
      appCommentForm: CommentForm
    }
  }
</script>