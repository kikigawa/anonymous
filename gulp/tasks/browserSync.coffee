path         = require "../utils/path.coffee"
gulp          = require 'gulp'
browserSync   = require 'browser-sync'
Config        = require '../utils/config'
@reload       = browserSync.reload

gulp.task 'browser-sync', (cb) ->

  a = path.forApp
  b = path.forBuild

  browserSync
    server:
      baseDir: './build'


  # cb()
