<template>
    <div>
        <p>{{ actor.first_name }} {{ actor.middle_name }} {{ actor.last_name }}</p>
    </div>
</template>

<script>
    export default {
        props: ['actor']
    }
</script>