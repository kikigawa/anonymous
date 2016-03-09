path    = require "path"
url     = require "url"
fs      = require "fs"
yaml    = require "js-yaml"


module.exports = (file) ->
  # root      = "./build/"
  # dir       = path.dirname file.path
  # relative  = path.relative dir, root
  # name      = path.relative(root, dir)



  data =
    meta: yaml.safeLoad fs.readFileSync "./app/common/data/meta.yml", "utf8"
    # id: name
    # root: file
    # root: url.format(urlObj)
