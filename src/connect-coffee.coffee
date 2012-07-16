# Modules
coffee = require 'coffee-script'
helper = require './helper'

# Compiler
compile = (filename, data, cb) ->
  cb null, coffee.compile data, {filename}

# Export middleware
module.exports = (dir) ->
  helper dir, /\.js$/, '.coffee', compile
