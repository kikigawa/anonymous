gutil   = require "gulp-util"

class UA
  constructor: ->
    @forApp = null
    @forBuild = null
    @initPath(gutil.env.type)


  initPath:(e) =>
    if e is 'sp'
      @forApp = '/sp/'
      @forBuild = '/sp/'
    else
      @forApp = '/pc/'
      @forBuild = '/'


module.exports = new UA()
