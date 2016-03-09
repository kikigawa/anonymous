path    = require '../utils/path.coffee'
gutil   = require 'gulp-util'
webpack = require 'webpack'
fs      = require 'fs'
# path    = require 'path'
# UA      = null

module.exports =
  class Config
    constructor: ->
      a = path.forApp
      b = path.forBuild

      @webpack =
        entry:
          # main: './app'+a+'scripts/main.coffee'
          main: './app/common/scripts/main.coffee'
          vendor: ['jquery','greensock']

        output:
          filename: '[name].js'

        module:
          loaders: [
           { test: /jquery\.js$/, loader: 'expose?jQuery!expose?$' }
           { test: /\.coffee$/, loader: 'coffee-loader' }
          ]
        resolve:
          modulesDirectories: ['node_modules', 'bower_components']
          extensions: ['', '.coffee', '.webpack.js', '.web.js', '.js']

        plugins: [
          new webpack.ResolverPlugin([
           new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
          ])
          new webpack.ProvidePlugin
           $: 'jquery'
           jQuery: 'jquery'

          new webpack.optimize.CommonsChunkPlugin('vendor','vendor.bundle.js')
        ]
