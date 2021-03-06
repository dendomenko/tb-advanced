function voteAnswerEvent() {
    function showNewAnswerRating(e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        $('#rating_' + response.id).html(response.rating);
        $('[data-id=' + response.id + ']').show();
    }
    function showAnswerVotingErrors(e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        console.log(response);
        if (e.detail[2].status === 401) {
            $('#answers-errors').html(response.error);
        }
        $.each(response.errors, function (index, value) {
            $('#answers-errors').html(value);
        });
    }
    $('.answer-voting').bind('ajax:success', showNewAnswerRating).bind('ajax:error', showAnswerVotingErrors);
}

function answerEditEvent() {
    $('.edit-answer-link').click(function (e) {
        e.preventDefault();
        var answer_id;
        $(this).hide();
        answer_id = $(this).data('answerId');
        $('form#edit-answer-' + answer_id).show();
    });
}

function unvoteAnswerEvent() {
    $('.unvote-answer').bind('ajax:success', function (e) {
        var id, xhr;
        xhr = e.detail[2];
        id = $(this).data('id');
        $('#rating_' + id).html(xhr.responseText);
        $(this).hide();
    });
}

function showAnswerCommentForm() {

    $('.show-answer-comment-form').click(function (e) {
        e.preventDefault();
        $(this).parent().parent().find('.answer-comment-form').toggleClass('hidden');

    });

    $('.add-comment').click(function (e) {
        $(this).parent().parent().addClass('hidden');
    });
}

function answerEvents() {
    answerEditEvent();
    voteAnswerEvent();
    unvoteAnswerEvent();
    showAnswerCommentForm();
}

function answerChannel() {
    if (($('.answers').length)) {
        var question_id;
        question_id = $('.question').data('questionId');
        App.answers = App.cable.subscriptions.create({
            channel: "AnswersChannel",
            question_id: question_id
        }, {
            received: function (data) {
                var current_user;
                current_user = $('body').data('currentUser');
                if (current_user !== data.user_id) {
                    console.log(data);
                    // $('.answers').append(renderAnswerHtml(data));
                    data.attachments = data.attachments.map(function(value) {
                        return {url: value.file.url, name: value.file.url.substring(value.file.url.lastIndexOf('/')+1)};
                    });
                    data.author = false;
                    data.isLogged = !!current_user
                    console.log(data);
                    if (current_user === data.question_author_id) {
                        data.author = true
                    }
                    $('.answers').append(Mustache.to_html($('#answer_template').html(), data));
                    answerEvents();
                    commentsChannel();
                }
            }
        });
    } else if (App.answers) {
        App.answers.unsubscribe();
        App.answers = null;
    }
}

function commentsChannel() {
    if (($('.answers').length)) {
        var question_id;
        question_id = $('.question').data('questionId');
        App.comments = App.cable.subscriptions.create({
            channel: "CommentsChannel",
            question_id: question_id
        }, {
            received: function (data) {
                switch (data.type) {
                    case 'Question':
                        $('.question-comments > .row > .comments').append(data.html);
                        break;
                    case 'Answer':
                        $('.answer-comments-'+data.id).append(data.html);
                        break;
                }
            }
        });
    } else if (App.comments) {
        App.comments.unsubscribe();
        App.comments = null;
    }
}

$(document).on('turbolinks:load', function () {
    answerEvents();
    answerChannel();
    commentsChannel();
});


