'use strict'

class Browser

  constructor: ->
    @isIE = false
    @isIE8 = false
    @isIE9 = false
    @isFirefox = false
    @isSafari = false
    @isMobile = false
    @isAndroid = false
    @isiOS = false
    @init()

  init: =>
    @userAgent = navigator.userAgent.toLowerCase()
    if @userAgent.match(/msie ([\d\.]+)/)
      @isIE = true
      if matched = @userAgent.match(/msie ([\d\.]+)/)
        version = matched[1].split('.')
        @isIE8 = (version[0] ^ 0) == 6
        @isIE8 = (version[0] ^ 0) == 7
        @isIE8 = (version[0] ^ 0) == 8
        @isIE9 = (version[0] ^ 0) == 9
        @isIE10 = (version[0] ^ 0) == 10
        @isIE11 = (version[0] ^ 0) == 11
    else if @userAgent.match('firefox')
      @isFirefox = true
    else if @userAgent.match('safari')
      @isSafari = true

    if @userAgent.search(/iphone/) != -1 or @userAgent.search(/ipad/) != -1 or @userAgent.search(/ipod/) != -1
      @isMobile = true
      @isiOS = true
    else if @userAgent.search(/android/) != -1
      @isMobile = true
      @isAndroid = true

    # trace '@isIE = '+ @isIE
    # trace '@isIE8 = '+ @isIE8
    # trace '@isFirefox = '+ @isFirefox
    # trace '@isMobile = '+ @isMobile
    # trace '@isAndroid = '+ @isAndroid
    # trace '@isiOS = '+ @isiOS
    # alert @isIE8


  redirect: (hash) =>
    if @isMobile
      location.href = location.host + '/#' + hash

module.exports = new Browser()
