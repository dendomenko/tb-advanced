<template>
    <div class="row">
        <div class="container">
            <h1>{{ movie.title}}</h1>
            <p>{{ movie.description }}</p>
            <ul>
                <li v-for="actor in movie.actors"> {{ actor.first_name}} {{actor.last_name}}</li>
            </ul>
        </div>
    </div>
</template>

<script>
    import Vue from "vue/dist/vue.esm";

    export default {
        data() {
            return {
                movie: {}
            }
        },
        beforeMount() {
            Vue.http.get('movies/' + this.$route.params.id)
                .then(response => {
                    this.movie = response.data;
                });
        }
    }
</script>