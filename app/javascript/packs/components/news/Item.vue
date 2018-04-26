<template>
    <div class="row">
        <b-img blank blank-color="#ccc" width="800" height="400" alt="placeholder"/>
        <h2>{{ item.title }}</h2>
        <p>{{ item.description }}</p>
    </div>
</template>

<script>
    import Vue from "vue/dist/vue.esm";

    export default {
        data(){
            return {
                item: {}
            }
        },
        created() {
            Vue.http.get('news/' + this.$route.params.id)
                .then(response => {
                    this.item = response.data;
                });
        }
    }
</script>