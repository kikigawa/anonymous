path        = require "../utils/path.coffee"
gulp        = require "gulp"
plumber     = require "gulp-plumber"
Config      = require "../utils/config.coffee"
gutil       = require "gulp-util"
data        = require "gulp-data"
jade        = require "gulp-jade"
# jade        = require "gulp-jade-php"
bSync       = require "./browserSync"


# html
gulp.task "jade", (cb)->
  a = path.forApp
  b = path.forBuild

  gulp.src("./app/common/layouts/index.jade")
    .pipe plumber()
    .pipe data (file) ->
      dp  = "../utils/data.coffee"
      out = require(dp)(file)
    .pipe jade
      pretty: true
    .on "error", gutil.log
    .pipe gulp.dest("./build/"+b)
    # .pipe gulp.dest("./build/sp/")
    .pipe bSync.reload stream: true


  # gulp.src("./app/common/layouts/index.jade")
  #   .pipe jade(locals: title: "OMG THIS IS THE TITLE")
  #   .pipe gulp.dest("./build/"+b)