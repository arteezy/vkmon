# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  format = 'HH:mm:ss DD.MM.YYYY'
  zone = moment.tz.guess()
  $('.last_seen').each ->
    time = $(this).text()
    $(this).text moment(time).tz(zone).format(format)
