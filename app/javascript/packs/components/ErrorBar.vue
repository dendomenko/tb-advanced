<template>
    <b-alert
            class="text-center"
            :show="showError"
            dismissible
            variant="danger"
            @dismissed="hideErrors">
        {{ errorText }}
    </b-alert>
</template>

<script>
  import {mapGetters} from 'vuex';
  import {mapActions} from 'vuex';

  export default {
    computed: {
      ...mapGetters({
        errorText: 'error/errorText',
        showError: 'error/show'
      })
    },
    methods: {
      ...mapActions({
        hideErrors: 'error/cleanError'
      })
    }
  }
</script>