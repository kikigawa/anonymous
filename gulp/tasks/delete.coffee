path        = require "../utils/path.coffee"
gulp        = require 'gulp'
del         = require 'del'

gulp.task 'delete', (cb)->
  a = path.forApp
  b = path.forBuild
  del ['build'+b+'images/sprites-dir'], cb