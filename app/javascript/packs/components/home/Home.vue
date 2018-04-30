<template>
    <b-jumbotron>
        <template slot="header">
            Latest News About Movies And TV-Series
        </template>
        <hr class="my-4">
        <app-news v-for="item in news" :news="item"></app-news>
    </b-jumbotron>
</template>

<script>
  import News from './News.vue';
  import {mapGetters} from 'vuex';

  export default {
    computed: {
      ...mapGetters({
        loading: 'news/loading',
        news: 'news/list'
      })
    },
    components: {
      appNews: News
    },
    created() {
      this.$store.dispatch('news/loadNews');
    }
  }
</script>
