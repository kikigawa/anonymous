Trace = require "./modules/trace"
Ua    = require "./modules/ua"

Top   = require "./page/top"


module.exports =

  class PC
    constructor: ->
      @Trace = new Trace
      # @Ua = new Ua
      trace "PC"

      page = $("#thispage").attr("page")
      $("html").attr "page", page
      if page is "top"      then @Top    = new Top

$ ->
  new PC()
