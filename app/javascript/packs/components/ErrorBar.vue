<template>
    <b-alert
            class="text-center"
            :show="showDismissibleAlert"
            dismissible
            variant="danger"
            @dismissed="showDismissibleAlert=false">
        {{ errorText }}
    </b-alert>
</template>

<script>
    export default {
        data () {
            return {
                showDismissibleAlert: true
            }
        },
        computed: {
          errorText() {
            return this.$store.getters.getErrorText;
          }
        }
    }
</script>