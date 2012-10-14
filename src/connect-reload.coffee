# Modules
path = require 'path'
socketio = require 'socket.io'
util = require 'util'
watchr = require 'watchr'

# Prozac
debounce = (fn, timeout) ->
  return ->
    clearTimeout timeout
    timeout = setTimeout fn, 50

# Client-side script
client = ->
  # Honor address and port values
  server = '//%s:%s/'

  # Reload handler
  reload = ->
    io.connect(server).on 'connect-reload', ->
      document.location.reload true

  # Are we done yet?
  return reload() if io?

  # Lazy load socket.io
  script = document.createElement('script')
  script.src = server + 'socket.io/socket.io.js'
  script.onload = reload
  target = document.getElementsByTagName('script')[0]
  target.parentNode.insertBefore script, target.nextSibling

# Export middleware
module.exports = ({address, dir, port, server}) ->
  # Prep client-side script
  client = util.format "(#{client}());", address, port

  # Start watching files and open socket
  io = socketio.listen server, 'log level': 0

  # Reasonable emitter
  emit = debounce ->
    io.sockets.emit 'connect-reload'

  # Reload emitter
  reload = (file) ->
    # Ignore hidden files
    emit() if path.basename(file).indexOf '.'

  # Bind emitter to file changes
  watchr.watch
    ignoreHiddenFiles: true
    ignorePatterns: true
    listener: reload
    path: dir

  # Return middleware
  ({url}, res, next) ->
    # Guard reload requests
    return next() unless url.slice(-17) is 'connect-reload.js'

    # RAM for the win
    res.setHeader 'Content-Type', 'text/javascript'
    res.end client
