window.EnvelopesEditor = class EnvelopesEditor

  constructor: ->
    @show()
    @hide()

  show: ->
    $('.box-trigger').on "mouseenter", ->
      element = $(this).children('.action')
      element.removeClass('is-hidden')

  hide: ->
    $('.box-trigger').on "mouseleave", ->
      element = $(this).children('.action')
      element.addClass('is-hidden')

$(document).ready ->
  envelopesEditor = new EnvelopesEditor
