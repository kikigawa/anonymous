# webpack = require 'webpack'
# Config      = require '../utils/config'



# module.exports =
#   class Config
#    constructor: ->
#      @props = { nouhin: false }
#      # console.log @props
#      console.log gutil.env.type?
#      # console.log prod

#      @webpack =
#       # devtool: "#source-map"
#       entry:
#         pc: "./app/pc/assets/scripts/index.coffee"
#         vendor: ['jquery','greensock']

#       output:
#         filename: "[name].js"

#       module:
#         loaders: [
#          { test: /jquery\.js$/, loader: "expose?jQuery!expose?$" }
#          { test: /\.coffee$/, loader: 'coffee-loader' }
#         ]
#       resolve:
#         modulesDirectories: ['node_modules', 'bower_components']
#         extensions: ['', '.coffee', '.webpack.js', '.web.js', '.js']

#       plugins: [
#         new webpack.ResolverPlugin([
#          new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
#         ])
#         new webpack.ProvidePlugin
#          $: 'jquery'
#          jQuery: "jquery"

#         new webpack.optimize.CommonsChunkPlugin("vendor","vendor.bundle.js")
#       ]
