Browser      = require "../modules/browser"
# GoogleMap    = require "../modules/googlemap"
Video        = require "../modules/video"
Face         = require "../modules/face"



class Top
  constructor: ->
    trace "TOP"
    @Video     = new Video
    @Face      = new Face

    @archive = $("#archive")
    @setEvent()
    @init()

  setEvent: =>  
    $(window).on "load", =>
      @changeVideoSize()
      @getAnonymous()
      # @pos()
      @Face.startVideo(@pos)
      

    $(window).on "resize", =>
      @changeVideoSize()


    $("#publish").on "click", =>
      
      png = @img_jpeg_src
      now = $.now()
      
      # 画像と現在時刻を渡す。
      # upload.phpは画像を現在時刻にリネームして保存する。
      $.ajax
        type: "POST"
        # url: "set_img.php"
        url: "upload.php"
        data:
          img : png
          date: now
        success: (json) =>
          trace "success upload"


      #databaseに画像名を保存する。
      $.ajax
        type: "POST"
        url: "set_img.php"
        data:
          date: now
        success: (json) =>
          trace "success set_img"

          #jsonを創る
          $.ajax
            type: "POST"
            url: "archive.php"
            data:
              date: now
            success: (json) =>
              trace "success archive"
              window.location.href = location.origin+"?id="+now

    
    $("#camera").on "click", =>
      trace "kamera"
      @img_jpeg_src = $("#canvas")[0].toDataURL("image/jpeg")
      $(".img").remove()
      $("#image_jpeg").after("<img class='img' id='img_1' src='"+@img_jpeg_src+"'>")


    $("#overlay-area .bg").on "click", =>
      $("#overlay-area").css "display", "none"


  init: =>
    if location.search
      id = location.search.replace("?id=", "")
      trace id
      @overlay(id)
      # $("#canvas").after("<img src='"+id+"'>")

  changeVideoSize: =>
    # $("#videoel, #overlay, #canvas").css {
    #   "width"  : $(window).width()
    #   "height" : $(window).width() * 3/4 +"px"
    # }
    # trace "resize"


  overlay: (id)=>
    $("#overlay-area").css(
      "display": "block"
    )
    $("#overlay-area img").attr "src", "./files/"+id+".png"


  
  getAnonymous: =>
    $.ajax
      type: "GET"
      url: "./data/anonymous.json"
      dataType: "json"
      success: (json) =>
        trace json
        for k,v of json
          id = v.id
          img = v.img
          now = img.replace("files/", "").replace(".png", "")
          $("ul", @archive).prepend("<li num='"+id+"'><a href='./?id="+now+"'><img src='"+img+"'></a></li>")

  pos: (pos)=>
    @Video.drawStart(pos)

  
module.exports = Top
