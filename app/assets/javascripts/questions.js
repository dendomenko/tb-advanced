function editQuestionEvent() {
    function showEditForm(e) {
        e.preventDefault();
        var question_id;
        $(this).hide();
        question_id = $(this).data('questionId');
        return $('form#edit-question-' + question_id).show();
    }
    return $('.edit-question-link').click(showEditForm);
}

function voteQuestionEvent() {
    function showNewRating(e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        $('.question-rating').html(response.rating);
        return $('.unvote-question').show();
    }
    function showVotingErrors(e) {
        var errors, response;
        response = JSON.parse(e.detail[2].response);
        if (e.detail[2].status === 401) {
            return $('.question-errors').html(response.error);
        }
        errors = response.errors;
        return $.each(errors, function (index, value) {
            return $('.question-errors').html(value);
        });
    }
    return $('form.quesion-voting').bind('ajax:success', showNewRating).bind('ajax:error', showVotingErrors);
}

function unvoteQuesionEvent() {
    function removeVote(e) {
        var xhr;
        xhr = e.detail[2];
        $('.question-rating').html(xhr.responseText);
        return $('.unvote-question').hide();
    }
    return $('.unvote-question').bind('ajax:success', removeVote);
}

function questionEvents() {
    editQuestionEvent();
    voteQuestionEvent();
    unvoteQuesionEvent();
}

$(document).on('turbolinks:load', function () {
    questionEvents();
    if ($('.questions').length) {

    }
});
