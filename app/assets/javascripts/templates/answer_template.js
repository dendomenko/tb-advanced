function renderAnswerHtml(data) {
    return '<div class="container text-left border" id="answer_' + data.answer.id + '"><p class="answer">' + data.answer.body +'</p>\n' +
        votingHtml(data) +
        attachmentsHtml(data) +
        bestAnswerHtml(data) +
        ' <p></p>' +
    '</div>'
}

function votingHtml(data) {
    return '    <div class="voting">\n' +
    '        <div id="answer_'+ data.answer.id + '-errors"></div>\n' +
    '        <a data-type="json" class="answer-voting btn btn-outline-success btn-sm" data-remote="true" rel="nofollow"\n' +
    '           data-method="post" href="/questions/'+ data.question_id +'/answers/'+ data.answer.id +'/upvote">\n' +
    '            vote up\n' +
    '        </a>\n' +
    '        <p id="rating_'+ data.answer.id +'">0</p>\n' +
    '        <a data-type="json" class="answer-voting btn btn-outline-danger btn-sm"\n' +
    '                                  data-remote="true" rel="nofollow" data-method="post"\n' +
    '                                  href="/questions/'+ data.question_id +'/answers/'+ data.answer.id +'/downvote">\n' +
    '            vote down\n' +
    '        </a>\n' +
    '        <a data-type="json" data-id="'+ data.answer.id +'" class="unvote-answer" style="display: none" data-remote="true" rel="nofollow" data-method="delete" href="/questions/'+ data.question_id +'/answers/'+ data.answer.id +'/unvote">\n' +
    '            Unvote\n' +
    '        </a>\n' +
    '    </div>\n'
}

function bestAnswerHtml(data) {
    current_user = $('body').data('currentUser');
    if (data.question_author_id === current_user) {
        return '    <a class="btn btn-outline-success btn-sm best-answer-link" data-answer-id="'+ data.answer.id +'" data-remote="true" rel="nofollow"' +
            '       data-method="patch" href="/questions/'+ data.question_id +'/answers/'+ data.answer.id +'/best">' +
            '        Best Answer</a>'
    }
    return '';
}

function attachmentsHtml(data) {
    if (data.answer.attachments.length) {
            b = $.map(data.answer.attachments, function (value, index) {
                return '<li><a href="'+ value.file.url +'">'+ value.file.url.substring(value.file.url.lastIndexOf('/')+1) +'</a></li>';
            });
        return '<ul class="answer-attachments">'+ b.join(' ') + '</ul>';
    }
    return '';
}