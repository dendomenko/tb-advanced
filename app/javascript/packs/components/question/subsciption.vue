<template>
    <div class="subscription">
        <a v-if="isSubscribed" @click="unsubscribe" class="subscribe-control">
            <span data-toggle="tooltip" data-placement="right" title="" class="oi oi-ban" data-original-title="Unsubscribe from updates"></span>
        </a>

        <a v-else @click="subscribe" class="subscribe-control">
            <span data-toggle="tooltip" data-placement="right" title="" class="oi oi-envelope-open" data-original-title="Subscribe for updates"></span>
        </a>
    </div>
</template>

<script>
    import axios from 'axios'
    const csrfToken = document.querySelector("meta[name=csrf-token]").content;
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;
    export default {
        name: 'subscription',
        props: ['url', 'initialIsSubscribed'],
        data: function () {
            return {
                isSubscribed: this.initialIsSubscribed
            }
        },
        methods: {
            subscribe: function () {
                axios.post(this.url + '/subscriptions.json')
                    .then(function (response) {
                        this.isSubscribed = true
                    }.bind(this))
                    .catch(function (error) {
                        console.log('subscribe error')
                    });
            },
            unsubscribe: function () {
                axios.delete(this.url +'/subscriptions.json')
                    .then(function (response) {
                        this.isSubscribed = false
                    }.bind(this))
                    .catch(function (error) {
                        console.log('unsubscribe error')
                    });
            },
        }
    }
</script>

<style scoped>
    .subscribe-control {
        position: relative;
        width: 40px;
        height: 40px;
        font-size: 22px;
        margin-left: 16px;
        margin-bottom: 10px;
    }
</style>