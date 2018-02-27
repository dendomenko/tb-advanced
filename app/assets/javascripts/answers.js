function voteAnswerEvent() {
    return $('form.answer-voting').bind('ajax:success', function (e) {
        var response;
        response = JSON.parse(e.detail[2].response);
        $('#rating_' + response.id).html(response.rating);
        return $('[data-id=' + response.id + ']').show();
    }).bind('ajax:error', function (e) {
        var errors, response;
        response = JSON.parse(e.detail[2].response);
        if (e.detail[2].status === 401) {
            return $('.answer-errors').html(response.error);
        }
        return $.each(response.errors, function (index, value) {
            return $('#answer_' + response.id + '-errors').html(value);
        });
    });
}

function answerEditEvent() {
    return $('.edit-answer-link').click(function (e) {
        var answer_id;
        e.preventDefault();
        $(this).hide();
        answer_id = $(this).data('answerId');
        return $('form#edit-answer-' + answer_id).show();
    });
}

function unvoteAnswerEvent() {
    return $('.unvote-answer').bind('ajax:success', function (e) {
        var id, xhr;
        xhr = e.detail[2];
        id = $(this).data('id');
        $('#rating_' + id).html(xhr.responseText);
        return $(this).hide();
    });
}

function answerEvents() {
    answerEditEvent();
    voteAnswerEvent();
    unvoteAnswerEvent();
}

$(document).on('turbolinks:load', function () {
    answerEvents()
});