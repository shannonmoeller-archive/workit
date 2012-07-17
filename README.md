workit
======

The stupid development server. Serves [CoffeeScript][coff], [Jade][jade], and
[Stylus][styl] like a champ. Reloads browser on source-file change. Built with
[Connect][conn], [Socket.io][sock], [Commander.js][comm], and [hound][houn].
Inspired by visionmedia's [serve][serv] and nodejitsu's [http-server][hser].

[coff]: http://coffeescript.org/
[jade]: http://jade-lang.com/
[styl]: http://learnboost.github.com/stylus/
[conn]: http://senchalabs.org/connect/
[sock]: http://socket.io/
[comm]: http://visionmedia.github.com/commander.js/
[houn]: https://github.com/beefsack/node-hound/
[serv]: https://github.com/visionmedia/serve/
[hser]: https://github.com/nodeapps/http-server/

Installation
------------

    $ npm install -g workit

Usage
-----

### Command

```

    Usage: workit [options] [dir]

    Options:

      -h, --help              output usage information
      -V, --version           output the version number
      -a, --address <string>  set hostname [127.0.0.1]
      -f, --format <string>   connect logger format [dev]
      -p, --port <number>     set port nubmer [3000]

```

### Auto-reload

```

    HTML:
    <script src="/connect-reload.js"></script>

    Jade:
    script(src='/connect-reload.js')

```

License
-------

(The MIT License)

Copyright (c) Shannon Moeller &lt;me@shannonmoeller.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
