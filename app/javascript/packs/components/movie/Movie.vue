<template>
    <div class="row">
        <div class="container">
            <h1>{{ movie.title}}({{ movie.year | moment("YYYY") }})</h1>
            <p>{{ movie.description }}</p>
            <p></p>
            <div v-for="actor in movie.actors">
                <app-actor :actor="actor"></app-actor>
            </div>
        </div>
    </div>
</template>

<script>
    import Vue from "vue/dist/vue.esm";
    import Actor from "./Actor.vue";

    export default {
        data() {
            return {
                movie: {}
            }
        },
        created() {
            Vue.http.get('movies/' + this.$route.params.id)
                .then(response => {
                    this.movie = response.data;
                });
        },
        components: {
            appActor: Actor
        }
    }
</script>