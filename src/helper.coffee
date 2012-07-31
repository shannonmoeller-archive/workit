# Modules
connect = require 'connect'
fs = require 'fs'
path = require 'path'

# Export middleware generator
module.exports = (dir, match, extension, compile) ->
  # Return middleware
  ({url}, res, next) ->
    # Allow for index.html
    url += 'index.html' if url.slice(-1) is '/'

    # Serve source files as plain text
    if url.slice(-extension.length) is extension
      res.setHeader 'Content-Type', 'text/plain'

    # Check for valid extension
    return next() unless match.test url

    # Normalize path
    filename = path.join dir, url.replace(match, extension)

    # Check file exists
    return next() unless fs.existsSync filename

    # Compile or die trying
    try
      ins = fs.readFileSync filename, 'utf8'
      compile filename, ins, (err, out) ->
        throw err if err
        mime = connect.static.mime.lookup url
        res.setHeader 'Content-Type', mime
        res.end out
    catch err
      next err
