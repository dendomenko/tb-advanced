<template>
    <div>
        <b-form @submit="onSubmit" v-if="isLogged">
            <b-form-textarea id="comment"
                             v-model="form.text"
                             placeholder="Enter something"
                             :rows="3"
                             :max-rows="6">
            </b-form-textarea>
            <b-button type="submit" variant="primary">Submit</b-button>
        </b-form>
    </div>
</template>

<script>
  import {mapGetters} from 'vuex';

  export default {
    data() {
      return {
        form: {
          text: '',
          commentable_type: this.commentableType,
          commentable_id: this.$route.params.id
        }
      }
    },
    props: ['commentableType'],
    computed: {
      ...mapGetters({
        isLogged: 'authentication/isLogged',
        loading: 'comments/loading',
        userId: 'authentication/userId'
      })
    },
    methods: {
      onSubmit(evt) {
        evt.preventDefault();
        this.$store.dispatch('comments/addComment', this.form)
          .then(() => {
            this.form.text = '';
          });
      }
    }
  }
</script>