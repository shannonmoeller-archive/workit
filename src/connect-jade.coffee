# Modules
fs = require 'fs'
jade = require 'jade'
path = require 'path'

# Options
extension = /\.html?$/

# Export middleware
module.exports = (dir) ->
  # Return handler
  ({url}, res, next) ->
    # Allow for index.jade
    url += 'index.html' if url.slice(-1) is '/'

    # Check for valid extention
    return next() unless extension.test url

    # Normalize path
    filename = path.join dir, url.replace(extension, '.jade')

    # Check file exists
    return next() unless fs.existsSync filename

    # Parse and return
    try
      content = fs.readFileSync filename, 'utf8'
      html = jade.compile(content, {filename})()

      res.setHeader 'Content-Type', 'text/html'
      res.end html
    catch err
      next(err)
