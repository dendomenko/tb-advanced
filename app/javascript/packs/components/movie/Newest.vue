<template>
    <div>
        <div class="row">
            <div class="container-fluid">
                <b-card-group deck>
                    <b-card v-for="(movie, id) in movies"
                            :title="movie.title"
                            img-src="https://lorempixel.com/600/300/food/5/"
                            img-alt="Image"
                            img-top
                            tag="article"
                            style="max-width: 20rem;"
                            class="mb-2">
                        <p class="card-text">
                            {{ movie.description }}
                        </p>
                        <b-link href="#foo">More...</b-link>
                    </b-card>
                </b-card-group>
            </div>
        </div>
    </div>
</template>

<script>
    import Vue from "vue/dist/vue.esm";

    export default {
        data() {
            return {
                movies: []
            }
        },
        beforeMount() {
            Vue.http.get('movies')
                .then(response => {
                    this.movies = response.data;
                });
        }
    }
</script>