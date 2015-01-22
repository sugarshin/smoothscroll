$ = require 'jquery'

class SmoothScroll
  "use strict"

  _defaults:
    speed: 500
    fx: null
    onScrollBefore: ->
    onScrollAfter: ->

  _prepareTarget: ->
    if @$el.attr('href') isnt '#'
      @$target = $(@$el.attr('href'))

  _prepareFX: (fx) ->
    if typeof fx is 'function'
      $.easing['_smoothScroll'] = fx

  constructor: (@$el, opts) ->
    @opts = $.extend {}, @_defaults, opts
    @_prepareTarget()
    @_prepareFX @opts.fx
    @addEvent()

  scroll: ->
    unless @$target? then return
    @opts.onScrollBefore? @$el[0]
    val = @$target.offset().top
    $('html, body')
      .stop true, true
      .animate
        scrollTop: val
      ,
        duration: @opts.speed
        easing: '_smoothScroll'
      .promise()
      .done => @opts.onScrollAfter? @$el[0]
    return this

  addEvent: ->
    @$el.on 'click.smoothscroll', (ev) =>
      ev.preventDefault()
      @scroll()
    return this

  rmEvent: ->
    @$el.off 'click.smoothScroll'
    return this

if typeof define is 'function' and define.amd
  define -> SmoothScroll
else if typeof module isnt 'undefined' and module.exports
  module.exports = SmoothScroll
else
  window.SmoothScroll or= SmoothScroll
