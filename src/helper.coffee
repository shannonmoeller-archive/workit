# Modules
connect = require 'connect'
flow = require 'flow'
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

    # Compile or die trying
    flow.exec(
      # Check file exists
      -> fs.exists filename, this

      # Get real path
      (exists) ->
        return next() unless exists
        fs.realpath filename, this

      # Read real file
      (err, real) ->
        return next err if err
        filename = real
        fs.readFile filename, 'utf8', this

      # Compile template
      (err, data) ->
        return next err if err
        compile filename, data, this

      # Send response to browser
      (err, data) ->
        return next err if err
        res.setHeader 'Content-Type', connect.static.mime.lookup url
        res.end data
    )
