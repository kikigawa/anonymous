###
使い方
moduleSliderクラスに以下のオプションを指定する。
finger: item / area
(margin="40" endless="false" arrow="true" navi="true" finger="item")
###

MARGIN = 24

class Slider
  constructor: ->
    trace "slider"
    # $(window).on "load", =>
    @moduleSlider = $(".moduleSlider")
    @check()

  check: =>
    # trace "スライドの数："+$(".moduleSlider").length
    if @moduleSlider.length > 0 then @init()

  init: =>
    that = @
    @moduleSlider.each (i,e) =>
      t = $(e)
      finger = t.attr("finger")
      $(t).attr "moduleSliderNum", i+1

      children = t.children()
      # h        = children.height()
      h        = @getItemHeight(children)
      $(children).addClass("sliderItem")


      children.wrapAll("<ul class='sliderInner'></ul>")
      $(".sliderInner").before("<div class='fingerArea'></div>")


      # 矢印を追加するかどうか
      if $(t).attr("arrow") is "true" then @addArrow(t)
      # ナビゲーションを追加するかどうか
      if $(t).attr("navi") is "true" then @addNavi(t)

      $(t).css {
        # "marginLeft" : "50%"
      }
      $(".fingerArea", t).css {
        "display"  : if finger is "area" then "block" else "none"
        "position" : "absolute"
        "top"      : "0"
        "left"     : "0"
        "width"    : "100%"
        "height"   : h+"px"
        "zIndex"   : "100"
      }

      $(".sliderBtn").css {
        "zIndex"   : "120"
      }


      $(".sliderInner", t).css {
        "height"     : h+"px"
        "position"   : "relative"
        "marginLeft" : "50%"
      }
      $(children, t).css {
        "position"   : "absolute"
        # "marginLeft" : "-50%"
      }
      # @moduleSlider.css {
      #   "overflow" : "hidden"
      # }

      #currentクラスをつける
      $(".sliderInner", t).children().first().addClass("current")

      #並べる
      m = @getMargin(t)
      $(children, t).each (i,e) =>
        target = $(e)
        $(e).css "left", ($(e).width()+ m) * i

      # ループするかどうか
      if $(t).attr("endless") is "true" then @loopInit(t)

      #初期をセンタリング
      $(".sliderInner", t).css "left", -($(children).width())/2+"px"

      # 矢印の表示非表示
      if $(t).attr("endless") is "false" then @arrowState(t, "prev")

      #クリックイベント
      $(".btnPrev", t).on "click", -> if !that.lock then that.move(t, "prev")
      $(".btnNext", t).on "click", -> if !that.lock then that.move(t, "next")
      $(".slideNavi", t).on "click", -> if !that.lock and !$(this).hasClass("current") then that.move(t, parseInt($(this).attr("num")))

      fingerArea = if finger is "area" then $(".fingerArea", t) else $(".item", t)
      # $(document).bind "touchstart", fingerArea, ->
      fingerArea.bind "touchstart", ->
        trace "move"
        if !that.lock
          @fingerPos =
            x: event.changedTouches[0].pageX
            y: event.changedTouches[0].pageY

      # $(document).bind "touchmove", fingerArea, ->
      fingerArea.bind "touchmove", ->
        if !that.lock
          @fingerMoveIs = true
          # ページが動くのを止める
          # event.preventDefault()

          @fingerMove =
            x: event.changedTouches[0].pageX - @fingerPos.x
            y: event.changedTouches[0].pageY - @fingerPos.y

          #エリア内である程度横スクロールしたら、スクロール禁止する処理
          trriger = 14
          if @fingerMove.x > trriger or @fingerMove.x < -trriger then trace event.preventDefault()

      # $(document).bind "touchend", fingerArea, ->
      fingerArea.bind "touchend", ->
        if !that.lock
          if !@fingerMoveIs then return

          if @fingerMove.x > 50
            if $(t).attr("endless") is "false" and parseInt($(".sliderInner .current", t).attr("num")) is 1
              return false
            else
              that.move(t, "prev")

          else if @fingerMove.x < -50
            if $(t).attr("endless") is "false" and parseInt($(".sliderInner .current", t).attr("num")) is parseInt($(".sliderInner", t).children().length)
              return false
            else
            that.move(t, "next")

          @fingerMoveIs = false

  move: (t, num)=>
    @lock = true
    currentNum = parseInt($(".navigationArea .current", t).attr("num"))
    if typeof num != "number"
      num = if num is "prev" then currentNum - 1 else currentNum + 1
    direction = if num - currentNum > 0 then "next" else "prev"

    l = parseInt($(".sliderInner", t).css("left"))
    w = ($(".sliderItem", t).width() + @getMargin(t)) * (num - currentNum)
    dist = l - w
    TweenMax.to($(".sliderInner", t), 0.6, {"left":dist, ease:Power1.easeInOut, onComplete: =>
      if $(t).attr("endless") is "true" then @removeEnds(t, direction)
      #currentクラス変更
      @changeCurrent(t, direction, (num - currentNum))
      # arrowの表示非表示切り替え
      if $(t).attr("endless") is "false" then @arrowState(t, direction)
      @moveEnd(t)
      @lock = false
    })

    #要素追加したりするやつ
    if $(t).attr("endless") is "true"
      if direction is "prev" then @addFirst(t, num) else @addLast(t, num)







  getMargin: (t)=>
    margin = if $(t).attr("margin") then $(t).attr("margin") else 0
    return parseInt(margin)

  addArrow: (t)=>
    t.append("<div class='btnPrev sliderBtn'>＜</div><div class='btnNext sliderBtn'>＞</div>")
    # $(".sliderBtn", t).css {
      # "position" : "relative"
      # "zIndex"   : "100"
    # }

  addNavi: (t)=>
    t.append("<ul class='navigationArea'></ul>")

    i = 0
    while i < $(".sliderItem", t).length
      $(".navigationArea", t).append("<li class='slideNavi "+@getCurrent(i)+"' num='"+parseInt(i+1)+"'>・</li>")
      i++
    
    navigationAreaW = 0
    $(".slideNavi", t).each (i,e) =>
      target = $(e)
      w  = parseInt(target.width())
      ml = parseInt(target.css("marginLeft"))
      navigationAreaW = navigationAreaW + w + ml


    $(".navigationArea", t).css {
      "width"    : navigationAreaW+"px"
      "position" : "relative"
      "zIndex"   : "100"
    }


  getCurrent: (i)=>
    current = if i is 0 then "current" else ""
    return current

  loopInit: (t)=>
    item = $(".sliderInner", t).children().last()
    $(".sliderInner", t).prepend(item)
    m = @getMargin(t)
    item.css "left", (item.width()+m)*-1


  addFirst: (t, num)=>
    maxLng = $(".sliderInner", t).children().length
    before = $(".sliderInner .current", t).attr("num")
    i = 1
    while i <= before - num
      @moveNum = i
      first         = $(".sliderInner", t).children().first()
      n = if parseInt(first.attr("num"))-1 > 0 then parseInt(first.attr("num"))-1 else maxLng
      addItem      = $(".sliderItem[num='"+n+"']", t).clone(true)
      firstItemPos = parseInt($(first).css "left")
      addItem.prependTo($(".sliderInner", t))
      addItem.css "left", firstItemPos - addItem.width() - @getMargin(t)
      i++



  addLast: (t, num)=>
    maxLng = $(".sliderInner", t).children().length
    before = $(".sliderInner .current", t).attr("num")
    i = 1
    while i <= num - before
      @moveNum = i
      last         = $(".sliderInner", t).children().last()
      n = if parseInt(last.attr("num"))+1 <= maxLng then parseInt(last.attr("num"))+1 else 1
      addItem      = $(".sliderItem[num='"+n+"']", t).clone(true)
      lastItemPos = parseInt($(last).css "left")
      addItem.appendTo($(".sliderInner", t))
      addItem.css "left", lastItemPos + addItem.width() + @getMargin(t)
      i++


  removeEnds: (t, direction)=>
    i = 1
    while i <= @moveNum
      # trace "bbb: "+i
      i++
      item = if direction is "next" then $(".sliderInner", t).children().first() else $(".sliderInner", t).children().last()
      item.remove()


  changeCurrent: (t, direction, diff)=>
    if !diff
      diff = if direction is "prev" then -1 else 1

    obj =
      navi : $(".navigationArea", t)
      item : $(".sliderInner", t)

    $.each obj, (i, val) ->
      maxLng = $(val).children().length
      if parseInt($(".current", val).attr("num")) >= maxLng and direction is "next" then c = 1
      else if parseInt($(".current", val).attr("num")) <= 1 and direction is "prev"then c = maxLng
      else
        c = parseInt($(".current", val).attr("num"))+parseInt(diff)
      $(".current", val).removeClass("current")
      $(val).children("[num='"+c+"']").addClass("current")


  arrowState: (t, arrow) =>
    if arrow is "prev"
      $(".sliderBtn.btnNext", t).css "display", "block"
      if $(".sliderInner .current", t).prev().length is 0
        $(".sliderBtn.btnPrev", t).css "display", "none"
      else
        $(".sliderBtn.btnPrev", t).css "display", "block"

    if arrow is "next"
      $(".sliderBtn.btnPrev", t).css "display", "block"
      if $(".sliderInner .current", t).next().length is 0
        $(".sliderBtn.btnNext", t).css "display", "none"
      else
        $(".sliderBtn.btnNext", t).css "display", "block"

  #カスタムな処理
  moveEnd: (t)=>
    # trace "moveend"
    parent = $(t).parent(".plates")
    if parent.length != 0
      current = $(".slideNavi.current", parent).attr("num")
      infos = $(parent).find(".infos").children()
      infos.removeClass("current")
      $(".box-info[num='"+current+"']", parent).addClass("current")


  getItemHeight: (item)=>
    arr = []
    $(item).each (i,e) =>
      target = $(e)
      arr.push(target[0].clientHeight)
      trace target
    trace arr
    return Math.max.apply(null,arr)

module.exports = Slider
