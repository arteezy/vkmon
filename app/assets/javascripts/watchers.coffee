$(document).on 'turbolinks:load', ->
  # format time according to user's TZ
  format = 'HH:mm:ss DD.MM.YYYY'
  zone = moment.tz.guess()
  $('.last_seen').each ->
    time = $(this).text()
    $(this).text moment(time).tz(zone).format(format)

  # lazy load images & infinite scrolling of friends
  itemsPerScroll = 50
  threshold = 200

  $('img.lazy').lazyload
    threshold: threshold
    effect: 'fadeIn'
    placeholder: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAMAAAAp4XiDAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1NTc3MiwgMjAxNC8wMS8xMy0xOTo0NDowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTQgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDdFNUI3MTNEMzc2MTFFNEJEQ0U5MEI1NTJDRjY1QjUiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDdFNUI3MTREMzc2MTFFNEJEQ0U5MEI1NTJDRjY1QjUiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0N0U1QjcxMUQzNzYxMUU0QkRDRTkwQjU1MkNGNjVCNSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0N0U1QjcxMkQzNzYxMUU0QkRDRTkwQjU1MkNGNjVCNSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PjWctmkAAAGAUExURcjP18nQ2MzS2s3T287T283U287U287U3M7V3M/V3M/V3dDV3c/W3dDW3dDW3tHW3tDX3tHX3tHX39LX3tHY39LY39PY39TY39PZ39PZ4NTZ39TZ4NXZ4NTa4NXb4dXb4tbb4dbb4tbc4tfc4dfc4tjc49jd4tjd49nd49ne49ne5Nre5Nrf5Nrf5dvf5Nvf5dvg5dzh5t3h5t3i5t7i59/j59/j6ODj6ODk6ODk6eHk6eHl6eLm6uPm6uPn6+Tn6+To6+To7OXo7Obo7Obp7Obp7efq7ejq7ujr7unr7uns7+rs8Ort7+vt8Ovu8Ozu8ezv8e3v8u3w8u7w8u7w8+/w8+/x8+/x9PDy9PHz9fLz9fL09fL09vP09vT19/T29/X2+Pb3+ff4+fj5+vn5+vn6+vn6+/r6+/r7+/v7/Pz8/Pz8/f39/f39/v3+/v7+/v7//////////////////////////////////////////////////////////////1kp6qMAAAJQSURBVEjH3dZtVxJBFAdwfCB2xp3JIa61kUlGRmoPohUhRFmWUaaU0UYKtBpgQus3+H/1Xih42F12oVed7qs9O/s7uzv3nnsntDg/YiyG5owRYy40PyqZ/z8JSc6FIo+HooJpTMRchOTr/fLm8tS0A5FkC5tmtbKVEOQg8g0A4HCNUR+YelIHAMBeEQ7CDs5WsKFdGMUyh+iG9TDaT7RKd+nlhK5zpmmMX7pbx+lpz7yS/UTf7i19zhVL5v53c7eMzqdUuXv7d366n6gVeMUC633ZtyQ5doybHqI0+a53vSSdeYld+eEmrUyte/mcu7Ovrh9hYHQy3c3vKxh1zRokzFlBnjWm5zyft0spLTqgLKP3vF8xrgZWMs20Afv0PH2dSgfNAwAl7lP8rA6kHpwkngJAKbTWio/9BIq6D+G7QHGCJr8AwMmdyEw4C6AgfIjIA+1bYvnsH+qKbrcBrCgfou4DC+O5sccA0JyNxMNpADfJh1Ac2Crj4w4AbIfW24mQhYbwI4ZoXOxtu2rjuAZ81XzbhXbgTkte+BK+4ybJmC/R37qExf37mHjhIu8DiMy6yCPlT1TaKRqSAsh54m2rdU6KPKAnUxIAsHc1wtLHAIBUNIhQG0BlImqQnrQBVFlg549UASwrwzAM7QOArAwksgD8Ouv/chVoXqZAQnQMi/U6gaNYvEeSyKClk2EYShyhymkIQqyA9bAU2o06GnE11OAjvmaXVrN7gGmoIWcliUQNgLmkxYYfryqxUXw2q0aayCS9B+0/flT4i8PV6Ee4P3BY0xJC+PfGAAAAAElFTkSuQmCC'

  $('.friend').filter((index) ->
    $(this).offset().top > $(window).height() + threshold
  ).hide()

  $(window).scroll ->
    if $(document).height() - $(window).height() - $(this).scrollTop() == 0
      $('.friend:hidden:lt(' + itemsPerScroll + ')').show()
