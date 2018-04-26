<template>
    <div class="row">
        <b-img blank blank-color="#ccc" width="800" height="400" alt="placeholder"/>
        <h2>{{ item.title }}</h2>
        <p>{{ item.description }}</p>
    </div>
</template>

<script>
  import {mapGetters} from 'vuex';

  export default {
    computed: {
      ...mapGetters({
        loading: 'news_item/loading',
        item: 'news_item/item'
      })
    },
    created() {
      this.$store.dispatch('news_item/loadNewsItem', this.$route.params.id);
    }
  }
</script>