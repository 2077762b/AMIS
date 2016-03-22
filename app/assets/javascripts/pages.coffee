# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $("button#feedback").click (event) ->
    $("input#formid").val($(event.currentTarget).attr 'value')

  $("button#submit").click ->
    $.ajax
      url: "/feedback"
      type: 'POST'
      data:
        formid: $('input#formid').val()
        content: $('input#content').val()
        content: $('input#content').val()
        rating: $('input[name=rating]:checked').val()
      error: (data, textStatus, jqXHR) ->
        console.log textStatus
        console.log jqXHR
        console.log data.responseText
      success: (data) ->
        $("[data-dismiss=modal]").trigger({ type: "click" });




