require 'coffee-script/register'
require './gulp'

# gulp        = require 'gulp'
# jade        = require 'gulp-jade'
# compass     = require 'gulp-compass'
# webpack     = require 'gulp-webpack'
# del         = require 'del'
# webserver   = require 'gulp-webserver'
# runSequence = require 'run-sequence'
# plumber     = require 'gulp-plumber'
# Config      = require "./config.coffee"

# gc = new Config()
# pcDir = 'app/pc'



# gulp.task 'connect', ->
#   gulp.src 'build/'
#     .pipe webserver
#       livereload: true
#       host: "0.0.0.0"
#       # directoryListing: true
#       open: true

#   root: ['build']
#   port: 1337
#   livereload: true
#   open:
#     file: gc.props.index
#     browser: 'Google Chrome'



# # js
# gulp.task 'scripts', ->
#   gulp.src(pcDir+'/scripts/index.coffee')
#     .pipe webpack gc.webpack
#     .pipe gulp.dest('./build/scripts/')



# # html
# gulp.task 'jade', ->
#   gulp.src(pcDir+'/layout/index.jade')
#     .pipe jade
#       pretty: true
#     .pipe gulp.dest('./build/')



# # css
# gulp.task 'styles', ->
#   gulp.src(pcDir+'/styles/pc.sass')
#     .pipe plumber()
#     .pipe compass
#       css: './build/styles/'
#       sass: pcDir+'/styles/'
#     .pipe gulp.dest('./build/styles/')



# #clean
# gulp.task 'clean', (cd) ->
#   del ['./build/'], cd



# #copy
# gulp.task 'copy', ->
#   gulp.src(pcDir+'/scripts/index.coffee')
#     .pipe gulp.dest('./copy/')



# #watch
# gulp.task 'watch', ->
#   gulp.watch pcDir+'/layout/**/*.jade', ['jade']
#   gulp.watch pcDir+'/styles/*.sass', ['styles']
#   gulp.watch pcDir+'/scripts/index.coffee', ['scripts']



# gulp.task 'build', ['jade', 'styles', 'scripts']



# gulp.task 'default', ->
#   runSequence 'clean', 'build', 'connect', 'watch'



# gulp.task 'nouhin', ->
#   gc.grops.nouhin = true


