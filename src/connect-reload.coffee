# Modules
hound = require 'hound'
socketio = require 'socket.io'

# Export middleware
module.exports = ({dir, server}) ->
  # Open socket and start watching
  io = socketio.listen server
  dog = hound.watch dir

  # Reload handler
  reload = ->
    io.sockets.emit 'workit-reload'

  # Bind reload handler
  dog.on 'create', reload
  dog.on 'change', reload
  dog.on 'delete', reload

  # Return handler
  ({url}, res, next) ->
    # Handle reloads
    return next() unless url is '/workit.js'

    # RAM for the win
    res.setHeader 'Content-Type', 'text/javascript'
    res.end "
      io.connect('/').on('workit-reload', function () {
        document.location.reload(true);
      });"
