# Modules
fs = require 'fs'
stylus = require 'stylus'
path = require 'path'

# Options
extension = /\.css$/

# Export middleware
module.exports = (dir) ->
  # Return handler
  ({url}, res, next) ->
    # Check for valid extention
    return next() unless extension.test url

    # Normalize path
    filename = path.join dir, url.replace(extension, '.styl')

    # Check file exists
    return next() unless fs.existsSync filename

    # Parse and return
    try
      content = fs.readFileSync filename, 'utf8'
      stylus.render content, {filename}, (err, css) ->
        throw err if err
        res.setHeader 'Content-Type', 'text/css'
        res.end css
    catch e
      next(e)
