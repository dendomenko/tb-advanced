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
            $('.answer-errors').html(response.error);
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
        console.log('comm', question_id);
        App.answers = App.cable.subscriptions.create({
            channel: "AnswersChannel",
            question_id: question_id
        }, {
            received: function (data) {
                var current_user;
                current_user = $('body').data('currentUser');
                console.log(data);
                if (current_user !== data.answer.user_id) {
                    $('.answers').append(renderAnswerHtml(data));
                    answerEvents();
                }
            }
        });
    } else if (App.answers) {
        console.log('discomm');
        App.answers.unsubscribe();
        App.answers = null;
    }
}

$(document).on('turbolinks:load', function () {
    answerEvents();
    answerChannel();
});


