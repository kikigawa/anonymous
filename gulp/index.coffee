path       = require "./utils/path.coffee"
requireDir = require('require-dir')

# Require all task
requireDir './tasks', recurse: true
