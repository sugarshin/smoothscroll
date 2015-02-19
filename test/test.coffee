assert = require 'power-assert'

SmoothScroll = require '../smoothscroll'

mocha.setup 'bdd'
window.onload = ->
  if window.mochaPhantomJS
    mochaPhantomJS.run()
  else
    mocha.run()



# .test()
describe '.test()', ->
  it 'テストのテスト', ->
    assert true
