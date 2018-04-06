<template>
    <div class="voting">
        <a @click="vote('/up')" class="voting-control">
            <span class="oi oi-chevron-top"></span>
        </a>
        <p class="circle">{{rating}}</p>
        <a @click="vote('/down')" class="voting-control">
            <span class="oi oi-chevron-bottom"></span>
        </a>
        <a @click="removeVote" v-if="isVoted" class="voting-control">
            <span class="oi oi-x"></span>
        </a>
    </div>
</template>

<script>
    import axios from 'axios'
    const csrfToken = document.querySelector("meta[name=csrf-token]").content;
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;
    export default {
        name: 'rating',
        props: ['initialRating', 'url', 'initialIsVoted'],
        data: function () {
            return {
                rating: this.initialRating,
                isVoted: this.initialIsVoted
            }
        },
        methods: {
            vote: function (vote) {
                axios.post(this.url + vote + 'vote.json')
                    .then(function (response) {
                        this.rating = response.data.rating;
                        this.isVoted = true;
                    }.bind(this))
                    .catch(function (error) {
                        console.log(error.response.status);
                        error.response.data.errors.forEach(function (item) {
                           console.log(item[0])
                        });
                    });
            },
            removeVote: function () {
                axios.delete(this.url +'/unvote.json')
                    .then(function (response) {
                        this.rating = response.data;
                        this.isVoted = false;
                    }.bind(this))
                    .catch(function (error) {
                        console.log('unvote error')
                    });
            },
        }
    }
</script>

<style scoped>
    .voting-control {
        position: relative;
        width: 40px;
        height: 40px;
        font-size: 22px;
        margin-left: 16px;
        margin-bottom: 10px;
    }

    .circle {
        margin-top: 15px;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        font-size: 14px;
        color: #000;
        line-height: 48px;
        text-align: center;
        background: #fff;
        border: solid rgba(174, 174, 174, 0.73) 1px;
    }
</style>