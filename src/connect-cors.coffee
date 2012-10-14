# Modules
http = require 'http'
https = require 'https'
url = require 'url'

# Export middleware
module.exports = (req, res, next) ->
  left = req.url.slice 0, 14
  right = req.url.slice 14

  # Enable CORS for all requests
  res.setHeader 'Access-Control-Allow-Origin', '*'

  # Guard proxy requests
  return next() unless left is '/connect-cors/'

  # Parse url
  opts = url.parse right

  # Spoof request headers
  opts.headers = req.headers

  # Select correct module
  mod = if opts.protocol is 'https:' then https else http

  # Proxy request
  mod.get opts, (res2) ->
    # Spoof response headers
    for k in Object.keys res2.headers
      res.setHeader k, res2.headers[k]

    # Pipe data
    res2.pipe res
