<template>
    <div class="voting col-sm-1">
        <a @click="vote('up')" class="voting">
            <span class="oi oi-chevron-top"></span>
        </a>
        <p class="circle">{{rating}}</p>
        <a @click="vote('down')" class="voting">
            <span class="oi oi-chevron-bottom"></span>
        </a>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        name: 'rating',
        props: ['initialRating', 'id'],
        data: function () {
            return { rating: this.initialRating }
        },
        methods: {
            vote: function (vote) {
                axios.post('/questions/'+ this.id + '/' + vote + 'vote.json')
                    .then(function (response) {
                        console.log(response.data.rating);
                        this.rating = response.data.rating

                    }.bind(this))
                    .catch(function (error) {
                        console.log(error)
                    });
            }
        }
    }
</script>

<style>
    .voting {
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