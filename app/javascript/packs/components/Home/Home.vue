<template>
    <b-jumbotron>
        <template slot="header">
            Latest News About Movies And TV-Series
        </template>
        <template slot="lead">
        </template>
        <hr class="my-4">
        <app-news v-for="item in news" :news="item"></app-news>
    </b-jumbotron>
</template>

<script>
    import Vue from "vue/dist/vue.esm";
    import News from './News.vue';

    export default {
        data() {
            return {
                news: []
            }
        },
        components: {
            appNews: News
        },
        created() {
            Vue.http.get('news')
                .then(response => {
                    this.news = response.data;
                });
        }
    }
</script>
