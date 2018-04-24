<template>
    <div>
        <h3>{{ actor.first_name }} {{ actor.middle_name }} {{ actor.last_name }}</h3>
    </div>
</template>

<script>
    export default {
        props: ['actor']
    }
</script>