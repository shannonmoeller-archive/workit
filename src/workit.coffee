# Modules
connect = require 'connect'
path = require 'path'

# Middleware
coffee = require './connect-coffee'
cors = require './connect-cors'
jade = require './connect-jade'
reload = require './connect-reload'
stylus = require './connect-stylus'

# Export helpfulness
module.exports = ({address, dir, format, port}) ->
  # Create server
  app = connect()
  server = app.listen port, address

  # Default host
  address ?= 'localhost'

  # Setup middleware
  app.use(connect.favicon())
    .use(connect.logger format)
    .use(cors)
    .use(reload {address, dir, port, server})
    .use(coffee dir)
    .use(jade dir)
    .use(stylus dir)
    .use(connect.static dir)
    .use(connect.directory dir)

  # Notify
  console.log 'Serving %s at http://%s:%s/', dir, address, port

# Generic error handler
process.on 'uncaughtException', console.log
