# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

$(document).on 'turbolinks:load', ->
  $('form.answer-voting').bind 'ajax:success', (e) ->
    response = JSON.parse(e.detail[2].response)
    $('#rating_'+response.id).html(response.rating)