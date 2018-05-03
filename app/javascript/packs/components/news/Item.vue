<template>
    <div class="container">
        <div class="row">
            <b-img blank blank-color="#ccc" width="800" height="400" alt="placeholder"/>
            <h2>{{ item.title }}</h2>
            <p>{{ item.description }}</p>
        </div>
        <div class="row">
            <strong class="text-center">Comments</strong>
            <div v-for="comment in item.comments">
                <app-comment :comment="comment"></app-comment>
            </div>
            <app-comment-form commentable-type="News"></app-comment-form>
        </div>
    </div>
</template>

<script>
  import {mapGetters} from 'vuex';
  import Comment from '../comment/Comment.vue';
  import CommentForm from '../comment/CommentForm.vue';

  export default {
    computed: {
      ...mapGetters({
        loading: 'news_item/loading',
        item: 'news_item/item'
      })
    },
    components: {
      appComment: Comment,
      appCommentForm: CommentForm
    },
    created() {
      this.$store.dispatch('news_item/loadNewsItem', this.$route.params.id);
    }
  }
</script>