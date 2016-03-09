path        = require "../utils/path.coffee"
gulp        = require 'gulp'
webpack     = require 'gulp-webpack'
plumber     = require 'gulp-plumber'
Config      = require "../utils/config.coffee"
# Config      = require '../utils/config'
# wpconfig    = require '../utils/webpack'
bSync       = require './browserSync'
# uglify      = require 'gulp-uglify'
# gulpif      = require 'gulp-if'

gc = new Config()

gulp.task 'scripts', (cb)->
  a = path.forApp
  b = path.forBuild
  gulp.src('./app/common/scripts/*.coffee')
    .pipe webpack gc.webpack
    .pipe gulp.dest('./build/common/scripts/')
    .pipe bSync.reload stream: true
