# Modules
hound = require 'hound'
path = require 'path'
socketio = require 'socket.io'
util = require 'util'

# Prozac
debounce = (fn, timeout) ->
  return ->
    clearTimeout timeout
    timeout = setTimeout fn, 20

# Client
client = "
  (function () {
    var script, target, server = '//%s:%s/';

    function listen() {
      io.connect(server).on('connect-reload', function () {
        document.location.reload(true);
      });
    }

    if (typeof io === 'object' && io) {
      return listen();
    }

    script = document.createElement('script');
    script.src = server + 'socket.io/socket.io.js';
    script.onload = listen;

    target = document.getElementsByTagName('script')[0];
    target.parentNode.insertBefore(script, target.nextSibling);
  }());"

# Export middleware
module.exports = ({address, dir, port, server}) ->
  # Start watching files and open socket
  dog = hound.watch dir
  io = socketio.listen server, 'log level': 0

  # Be reasonable
  emit = debounce ->
    io.sockets.emit 'connect-reload'

  # Handler
  reload = (file) ->
    emit() if path.basename(file).indexOf '.'

  # Bind handler
  dog.on 'create', reload
  dog.on 'change', reload

  # Return middleware
  ({url}, res, next) ->
    # Handle reloads
    return next() unless url is '/connect-reload.js'

    # RAM for the win
    res.setHeader 'Content-Type', 'text/javascript'
    res.end util.format(client, address, port)
