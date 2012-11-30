'use strict'

# Modules
http = require 'http'
https = require 'https'
url = require 'url'

# Export middleware
module.exports = (req, res, next) ->
  # Enable CORS for all requests
  res.setHeader 'Access-Control-Allow-Origin', '*'
  res.setHeader 'Access-Control-Allow-Headers', 'X-Requested-With'

  # Guard proxy requests
  return next() unless req.url.slice(0, 14) is '/connect-cors/'

  # Parse url
  opts = url.parse req.url.slice(14)

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
