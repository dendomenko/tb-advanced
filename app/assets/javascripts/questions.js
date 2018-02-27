function editQuestionEvent() {
    return $('.edit-question-link').click(function (e) {
        var question_id;
        e.preventDefault();
        $(this).hide();
        question_id = $(this).data('questionId');
        console.log(question_id);
        return $('form#edit-question-' + question_id).show();
    });
}

function voteQuestionEvent() {
    return $('form.quesion-voting').bind('ajax:success', function (e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        $('.question-rating').html(response.rating);
        return $('.unvote-question').show();
    }).bind('ajax:error', function (e) {
        var errors, response;
        response = JSON.parse(e.detail[2].response);
        if (e.detail[2].status === 401) {
            return $('.question-errors').html(response.error);
        }
        errors = response.errors;
        return $.each(errors, function (index, value) {
            return $('.question-errors').html(value);
        });
    });
}

function unvoteQuesionEvent() {
    return $('.unvote-question').bind('ajax:success', function (e) {
        var xhr;
        xhr = e.detail[2];
        $('.question-rating').html(xhr.responseText);
        return $('.unvote-question').hide();
    });
}

function questionEvents() {
    editQuestionEvent();
    voteQuestionEvent();
    unvoteQuesionEvent();
}

$(document).on('turbolinks:load', function () {
    questionEvents();
});
