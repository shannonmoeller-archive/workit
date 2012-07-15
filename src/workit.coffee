# Modules
connect = require 'connect'
path = require 'path'

# Middleware
coffee = require './connect-coffee'
jade = require './connect-jade'
stylus = require './connect-stylus'

# Export helpfulness
module.exports = ({address, dir, format, port}) ->
  connect()
    .use(connect.favicon())
    .use(connect.logger format)
    .use(coffee dir)
    .use(jade dir)
    .use(stylus dir)
    .use(connect.static dir)
    .use(connect.directory dir)
    .listen port, address, ->
      console.log 'Serving %s at http://%s:%s',
        dir, address, port
