###!
 * @license smoothscroll
 * (c) sugarshin
 * License: MIT
###

"use strict"

$ = require 'jquery'

module.exports =
class SmoothScroll

  _$body = $('html, body')
  _collection = []

  @addEasing: (name, func) -> $.easing[name] = func

  @getCollection: -> _collection

  _defaults:
    speed: 700
    easingName: null
    offset: 0
    onScrollBefore: (el) ->
    onScrollAfter: (el) ->

  _configure: (el, opts) ->
    @$el = $(el)
    @opts = $.extend {}, @_defaults, opts
    if @$el.attr('href') isnt '#'
      @$target = $(@$el.attr('href'))
    _collection.push @

  constructor: (@el, opts) ->
    @_configure @el, opts
    @events()

  scroll: ->
    unless @$target? then return
    @opts.onScrollBefore? @$el[0]
    val = @$target.offset().top - @opts.offset
    _$body
      .stop true, true
      .animate
        scrollTop: val
      ,
        duration: @opts.speed
        easing: @opts.easingName
      .promise()
      .done => @opts.onScrollAfter? @$el[0]
    return this

  cancel: ->
    _$body.stop()
    return this

  _onClick: (ev) =>
    ev.preventDefault()
    @scroll()

  events: ->
    @$el.on 'click.smoothscroll', @_onClick
    return this

  unbind: ->
    @$el.off 'click.smoothScroll'
    return this
