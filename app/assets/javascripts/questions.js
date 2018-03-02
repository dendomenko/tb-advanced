function editQuestionEvent() {
    function showEditForm(e) {
        e.preventDefault();
        var question_id;
        $(this).hide();
        question_id = $(this).data('questionId');
        $('form#edit-question-' + question_id).show();
    }

    $('.edit-question-link').click(showEditForm);
}

function voteQuestionEvent() {
    function showNewRating(e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        $('.question-rating').html(response.rating);
        $('.unvote-question').show();
    }

    function showVotingErrors(e) {
        var errors, response;
        console.log(response);
        response = JSON.parse(e.detail[2].response);
        if (e.detail[2].status === 401) {
            $('.question-errors').html(response.error);
        }
        errors = response.errors;
        $.each(errors, function (index, value) {
            $('.question-errors').html(value);
        });
    }

    $('.quesion-voting').bind('ajax:success', showNewRating).bind('ajax:error', showVotingErrors);
}

function unvoteQuesionEvent() {
    function removeVote(e) {
        var xhr;
        xhr = e.detail[2];
        $('.question-rating').html(xhr.responseText);
        $('.unvote-question').hide();
    }

    $('.unvote-question').bind('ajax:success', removeVote);
}

function questionEvents() {
    editQuestionEvent();
    voteQuestionEvent();
    unvoteQuesionEvent();
}

function questionChannel() {
    if (($('.questions').length) || ($('#new_question').length)) {
        App.questions = App.cable.subscriptions.create({
            channel: "QuestionsChannel"
        }, {
            received: function (data) {
                $('.questions').append(data);
            }
        });
    } else if (App.questions) {
        App.questions.unsubscribe();
        App.questions = null;
    }
}

$(document).on('turbolinks:load', function () {
    questionEvents();
    questionChannel()
});
