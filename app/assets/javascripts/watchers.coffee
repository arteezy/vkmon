$(document).on 'turbolinks:load', ->
  format = 'HH:mm:ss DD.MM.YYYY'
  zone = moment.tz.guess()
  $('.last_seen').each ->
    time = $(this).text()
    $(this).text moment(time).tz(zone).format(format)

$(document).on 'turbolinks:load', ->
  $('.friendlist .page').infinitescroll
    navSelector: 'nav.pagination'
    nextSelector: 'nav.pagination a[rel=next]'
    itemSelector: '.friendlist .friend'
    loading: {
      finishedMsg: '<em>You\'ve reached the end of the friendlist!</em>'
      msgText: '<em>Loading the next batch of friends...</em>'
    }
