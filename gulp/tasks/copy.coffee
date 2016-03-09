path        = require "../utils/path.coffee"
gulp        = require 'gulp'
copy        = require 'gulp-copy'
del         = require 'del'


gulp.task 'copy', (cb)->
  a = path.forApp
  b = path.forBuild

  gulp.src('./app'+a+'images/**/*{png,jpg}')
    .pipe gulp.dest('./build'+b+'images/')

  gulp.src('./app/common/images/**/*{png,jpg}')
    .pipe gulp.dest('./build/common/images/')

  gulp.src('./app/common/scripts/plugin/*.js')
    .pipe gulp.dest('./build/common/scripts/plugin/')