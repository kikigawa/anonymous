class Face
  constructor: ->
    trace "Face"
    @vid = document.getElementById('videoel')
    navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia
    window.URL = window.URL or window.webkitURL or window.msURL or window.mozURL
    videoSelector = video: true
    if window.navigator.appVersion.match(/Chrome\/(.*?) /)
      chromeVersion = parseInt(window.navigator.appVersion.match(/Chrome\/(\d+)\./)[1], 10)
      if chromeVersion < 20
        videoSelector = 'video'
    navigator.getUserMedia videoSelector, ((stream) =>
      if @vid.mozCaptureStream
        @vid.mozSrcObject = stream
      else
        @vid.src = window.URL and window.URL.createObjectURL(stream) or stream
      @vid.play()
    ), ->
      insertAltVideo @vid
      document.getElementById('gum').className = 'hide'
      document.getElementById('nogum').className = 'nohide'
      alert 'There was some problem trying to fetch video from your webcam, using a fallback video instead.'

    @canvasInput = document.getElementById('overlay')
    @cc = @canvasInput.getContext('2d')
    @ctrack = new (clm.tracker)(useWebGL: true)
    @ctrack.init pModel

    
  startVideo: (cb)=>
    @callback = cb
    @vid.play()
    @ctrack.start @vid
    @drawLoop()
    

  drawLoop: =>
    requestAnimationFrame @drawLoop
    
    # 毎フレーム出力用のキャンバスをクリアします。これをしないと重ね書きのようになってしまいます。
    @cc.clearRect 0, 0, @canvasInput.width, @canvasInput.height
    
    # 判定結果をcanvasに描画します。
    @ctrack.draw @canvasInput
    
    #顔のpositionを渡す
    # @callback(@ctrack.getCurrentPosition())

    # return 

    
module.exports = Face
