function voteAnswerEvent() {
    $('.answer-voting').bind('ajax:success', function (e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        $('#rating_' + response.id).html(response.rating);
        $('[data-id=' + response.id + ']').show();
    }).bind('ajax:error', function (e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        console.log(response);
        if (e.detail[2].status === 401) {
            $('.answers-errors').html(response.error);
        }
        $.each(response.errors, function (index, value) {
            $('#answer_' + response.id + '-errors').html(value);
        });
    });
}

function answerEditEvent() {
    $('.edit-answer-link').click(function (e) {
        var answer_id;
        e.preventDefault();
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

function answerEvents() {
    answerEditEvent();
    voteAnswerEvent();
    unvoteAnswerEvent();
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
                if (current_user !== data.answer.user_id) {
                    $('.answers').append(renderAnswerHtml(data));
                    answerEvents();
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
        console.log('comm', question_id);
        App.comments = App.cable.subscriptions.create({
            channel: "CommentsChannel",
            question_id: question_id
        }, {
            received: function (data) {
                switch (data.type) {
                    case 'Question':
                        $('.question-comments').append(data.html);
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


