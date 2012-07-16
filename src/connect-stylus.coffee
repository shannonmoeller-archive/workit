# Modules
helper = require './helper'
stylus = require 'stylus'

# Compiler
compile = (filename, data, cb) ->
  stylus.render data, {filename}, cb

# Export middleware
module.exports = (dir) ->
  helper dir, /\.css$/, '.styl', compile
