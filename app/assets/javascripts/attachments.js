$(document).on('turbolinks:load', function () {
    $('.add-file').click(showFileInput);
    $('.remove-file').click(hideFileInput);
});

function showFileInput(e) {
    e.preventDefault();
    var fields;
    fields = $('.file-field');
    fields.append('<label for="file">File</label>');
    fields.append('<input name="file[]" id="file" type="file">');
}

function hideFileInput(e) {
    e.preventDefault();
    var fields;
    fields = $('.file-field');
    fields.children().last().remove();
    fields.children().last().remove();
}