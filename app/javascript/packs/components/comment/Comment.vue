<template>
    <div>
        <p><strong>{{ comment.user.email }}</strong></p>
        <p>{{ comment.text }}</p>
    </div>
</template>

<script>
  export default {
    props: ['comment']
  }
</script>