<template>
    <div class="voting col-sm-1">
        <a data-type="json" class="question-voting" data-remote="true" rel="nofollow"
           data-method="post" href="/questions/3/upvote">
            <span class="oi oi-chevron-top"></span>
        </a>
        <p class="circle question-rating">-1</p>
        <a data-type="json" class="question-voting" data-remote="true"
           rel="nofollow" data-method="post" href="/questions/3/downvote">
            <span class="oi oi-chevron-bottom"></span>
        </a>
        <a data-type="json" class="unvote-question" style="" data-remote="true" rel="nofollow" data-method="delete"
           href="/questions/3/unvote">
            <span class="oi oi-x"></span>
        </a>
        <a class="subscribe-question" rel="nofollow" data-method="post" href="/questions/3/subscriptions">
            <span class="oi oi-envelope-open" data-toggle="tooltip" data-placement="right"
                  title="Subscribe from updates"></span>
        </a>
    </div>
</template>

<script>
    export default {
        data: function () {
            return {
                message: "Hello Vue!"
            }
        }
    }
</script>

<style scoped>
    p {
        font-size: 2em;
        text-align: center;
    }
</style>
