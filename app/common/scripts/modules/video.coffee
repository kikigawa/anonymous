###
使い方
#map-canvasを要素を作成
###

class Video
  constructor: ->
    trace "Video"
    @vid = document.getElementById('videoel')
    @canvas  = document.getElementById("canvas")
    @ctx     = canvas.getContext("2d")
    # @ctx.scale(-1,-1)
    
    @webRTC()
    
    $(window).on "load", =>
      @canvasInit()
      # @drawStart()

    # $("input.btn").on "click", ->
    #   @startVideo()

  webRTC: =>
    that = @
    navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia
    window.URL = window.URL or window.webkitURL or window.msURL or window.mozURL
    videoSelector = video: true
    if window.navigator.appVersion.match(/Chrome\/(.*?) /)
      chromeVersion = parseInt(window.navigator.appVersion.match(/Chrome\/(\d+)\./)[1], 10)
      if chromeVersion < 20
        videoSelector = 'video'
    navigator.getUserMedia videoSelector, ((stream) ->
      if that.vid.mozCaptureStream
        that.vid.mozSrcObject = stream
      else
        that.vid.src = window.URL and window.URL.createObjectURL(stream) or stream
      that.vid.play()
    ), ->
      insertAltVideo that.vid
      document.getElementById('gum').className = 'hide'
      document.getElementById('nogum').className = 'nohide'
      alert 'There was some problem trying to fetch video from your webcam, using a fallback video instead.'

  canvasInit: =>
    @canvas.width  = $(@vid).width()
    @canvas.height = $(@vid).height()

  #videoタグの映像をcanvasに描画
  drawStart: (facePos)=>
    @ctx.drawImage @vid, 0, 0, $(@vid).width(), $(@vid).height()


    @ctx.scale(-1,1)
    @ctx.drawImage @vid, -$(@vid).width(), 0, $(@vid).width(), $(@vid).height()

    @mosaic(facePos)
    # requestAnimationFrame =>
    #   @drawStart()
  
  #canvasの映像にモザイクかける
  mosaic: (facePos)=>
    if !@once
      if facePos then @once = true
    
    p_left   = Math.round(facePos[1][0])
    p_right  = Math.round(facePos[13][0])
    p_top    = if facePos[21][1] > facePos[17][1] then Math.round(facePos[17][1]) else Math.round(facePos[21][1])
    p_bottom = Math.round(facePos[7][1])
    # trace p_left+", "+p_right

    imgData = @ctx.getImageData(0, 0, @canvas.width, @canvas.height)
    if imgData != ''
      dot = 6
      dotX = Math.round((p_right - p_left)/dot)
      dotY = Math.round((p_bottom - p_top)/dot)
      adjust = 10
      # 縦
      y = p_top + dotY
      num = 0
      while y < p_bottom + adjust
        # 横
        # 400 - とすることで左右反転に対応している。
        x = $(@vid).width() - p_right + dotX
        while x < $(@vid).width() - p_left + adjust
          # 1ピクセル = R + G + B + アルファ値(透過率) が格納されているので4ずつアップ
          i = y * 4 * imgData.width + x * 4
          m_y = y - dotY
          while m_y < y
            m_x = x - dotX
            while m_x < x
              m_i = m_y * 4 * imgData.width + m_x * 4
              imgData.data[m_i] = imgData.data[i]
              imgData.data[m_i + 1] = imgData.data[i + 1]
              imgData.data[m_i + 2] = imgData.data[i + 2]
              imgData.data[m_i + 3] = imgData.data[i + 3]
              m_x++
            m_y++
          x += dotX
        y += dotY
      # 生成したモノクロ画像データを適用
      # imgData.scale(-1,1)
      @ctx.putImageData imgData, 0, 0
      # @ctx.scale(-1,1)
      # @ctx.drawImage @vid, -$(@vid).width(), 0, $(@vid).width(), $(@vid).height()

module.exports = Video
