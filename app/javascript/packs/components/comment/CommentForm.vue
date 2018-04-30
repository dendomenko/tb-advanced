<template>
    <div>
        <b-form @submit="onSubmit" v-if="isLogged">
            <b-form-textarea id="textarea1"
                             v-model="text"
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
        text: ''
      }
    },
    computed: {
      ...mapGetters({
        isLogged: 'authentication/isLogged',
        loading: 'comments/loading'
      })
    },
    methods: {
      onSubmit(evt) {
        evt.preventDefault();
        this.$store.dispatch('comments/addComment', this.form);
      }
    }
  }
</script>