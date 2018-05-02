<template>
    <div class="row">
        <div class="col-md-8">
            <b-card>
                <b-media no-body>
                    <b-media-aside vertical-align="center">
                        <b-img blank blank-color="#ccc" width="348" height="196" alt="placeholder"/>
                    </b-media-aside>
                    <b-media-body class="ml-3">
                        <router-link :to="{name: 'news', params: { id: news.id } }"
                                     tag="h3"
                                     style="cursor: pointer">
                            {{ news.title}}</router-link>
                        <p>
                            {{ news.description }}
                        </p>
                    </b-media-body>
                </b-media>
            </b-card>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['news']
    }
</script>