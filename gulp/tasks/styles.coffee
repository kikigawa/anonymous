path        = require "../utils/path.coffee"
gulp        = require 'gulp'
compass     = require 'gulp-compass'
plumber     = require 'gulp-plumber'
gutil       = require "gulp-util"
Config      = require '../utils/config.coffee'
bSync       = require './browserSync'
# minifyCSS   = require 'gulp-minify-css'
# gulpif      = require 'gulp-if'

gulp.task 'styles', (cb)->
  a = path.forApp
  b = path.forBuild
  opts =
    css: 'build'+b+'styles'
    sass: 'app'+a+'styles'
    image: 'build'+b+'images'

  gulp.src('./app'+a+'styles/*.sass')
    .pipe plumber()
    .pipe compass opts
    .on "error", gutil.log
    .pipe gulp.dest('./build'+b+'styles/')
    .pipe bSync.reload stream: true
