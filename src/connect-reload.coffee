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
    io.sockets.emit 'connect-reload'

  # Bind reload handler
  dog.on 'create', reload
  dog.on 'change', reload

  # Return handler
  ({url}, res, next) ->
    # Handle reloads
    return next() unless url is '/connect-reload.js'

    # RAM for the win
    res.setHeader 'Content-Type', 'text/javascript'
    res.end "
      (function(){
        var script = document.createElement('script');
        script.src = '/socket.io/socket.io.js';
        script.onload = function () {
          io.connect('/').on('connect-reload', function () {
            document.location.reload(true);
          });
        };
        document.getElementsByTagName('head')[0].appendChild(script);
      }());"
