# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.edit-question-link').click (e) ->
    e.preventDefault()
    $(this).hide
    question_id = $(this).data('questionId')
    console.log(question_id)
    $('form#edit-question-' + question_id).show()

$(document).on 'turbolinks:load', ->
  $('form.quesion-voting').bind 'ajax:success', (e) ->
    response = JSON.parse(e.detail[2].response)
    $('.question-rating').html(response.rating)
    $('.unvote-question').show()
  .bind 'ajax:error', (e) ->
    response = JSON.parse(e.detail[2].response)
    if (e.detail[2].status == 401)
      return $('.question-errors').html(response.error)
    errors = response.errors
    $.each errors, (index, value) ->
      $('.question-errors').html(value)

$(document).on 'turbolinks:load', ->
  $('.unvote-question').bind 'ajax:success', (e) ->
    xhr = e.detail[2]
    $('.question-rating').html(xhr.responseText)
    $('.unvote-question').hide()