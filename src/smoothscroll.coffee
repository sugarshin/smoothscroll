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

  @canselScroll: -> _$body.stop()

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
    @opts.onScrollBefore? @el
    val = @$target.offset().top - @opts.offset
    _$body
      .stop true, true
      .animate
        scrollTop: val
      ,
        duration: @opts.speed
        easing: @opts.easingName
      .promise()
      .done => @opts.onScrollAfter? @el
    return this

  destroy: ->
    @unbind()
    for el, i in _collection
      if el is @
        _collection.splice i, 1
        break

  _onClick: (ev) =>
    ev.preventDefault()
    @scroll()

  events: ->
    @$el.on 'click.smoothscroll', @_onClick
    return this

  unbind: ->
    @$el.off 'click.smoothScroll'
    return this
