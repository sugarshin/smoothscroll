###!
 * @license smoothscroll
 * (c) sugarshin
 * License: MIT
###

"use strict"

do (root = this, factory = ($) ->

  class SmoothScroll

    @addEasing: (name, func) ->
      if $.easing[name]? then return
      $.easing[name] = func

    _defaults:
      speed: 500
      easingName: null
      offset: 0
      onScrollBefore: (el) ->
      onScrollAfter: (el) ->

    _configure: (el, opts) ->
      @$el = $(el)
      @opts = $.extend {}, @_defaults, opts
      if @$el.attr('href') isnt '#'
        @$target = $(@$el.attr('href'))

    constructor: (@el, opts) ->
      @_configure @el, opts
      @events()

    scroll: ->
      unless @$target? then return
      @opts.onScrollBefore? @$el[0]
      val = @$target.offset().top - @opts.offset
      $('html, body')
        .stop true, true
        .animate
          scrollTop: val
        ,
          duration: @opts.speed
          easing: @opts.easingName
        .promise()
        .done => @opts.onScrollAfter? @$el[0]
      return this

    events: ->
      @$el.on 'click.smoothscroll', (ev) =>
        ev.preventDefault()
        @scroll()
      return this

    unbind: ->
      @$el.off 'click.smoothscroll'
      return this

) ->
  if typeof module is 'object' and typeof module.exports is 'object'
    module.exports = factory require 'jquery'
  else
    root.SmoothScroll or= factory root.jQuery
  return
