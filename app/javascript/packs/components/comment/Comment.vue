<template>
    <div v-if="exist">
        <p><strong>{{ comment.user.email }}</strong></p>
        <p>{{ comment.text }}</p>
        <strong v-if="comment.user.id === userId" @click="deleteComment">X</strong>
    </div>
</template>

<script>
  import {mapGetters} from 'vuex';

  export default {
    props: ['comment'],
    data() {
      return {
        exist: true
      }
    },
    computed: {
      ...mapGetters({
        userId: 'authentication/userId'
      })
    },
    methods: {
      deleteComment() {
        this.$store.dispatch('comments/deleteComment', this.comment.id).then(() => {
          this.exist = false
        });
      }
    }
  }
</script>