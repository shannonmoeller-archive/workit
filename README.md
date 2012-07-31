workit
======

The stupid development server.

- Reloads browser on source-file change.
- Serves [CoffeeScript][coff], [Jade][jade], and [Stylus][styl] like a champ.
- Compiled output sent directly to browser for a pristine working directory.
- No caching so you're guaranteed to get the latest changes.

[coff]: http://coffeescript.org/
[jade]: http://jade-lang.com/
[styl]: http://learnboost.github.com/stylus/

Built with [Connect][conn], [Socket.io][sock], [Commander.js][comm], and
[hound][houn]. Inspired by visionmedia's [serve][serv] and nodejitsu's
[http-server][hser].

[conn]: http://senchalabs.org/connect/
[sock]: http://socket.io/
[comm]: http://visionmedia.github.com/commander.js/
[houn]: https://github.com/beefsack/node-hound/
[serv]: https://github.com/visionmedia/serve/
[hser]: https://github.com/nodeapps/http-server/

Installation
------------

Via [npm](http://npmjs.org/):

    $ npm install -g workit

Usage
-----

### workit(1)

```

    Usage: workit [options] [dir]

    Options:

      -h, --help              output usage information
      -V, --version           output the version number
      -a, --address <string>  set hostname [127.0.0.1]
      -f, --format <string>   connect logger format [dev]
      -p, --port <number>     set port number [3000]

    Examples:

      Serve the current directory

        $ cd /var/www
        $ workit
        Serving /var/www at http://localhost:3000/

      Serve a specific directory

        $ workit /var/www/foo
        Serving /var/www/foo at http://localhost:3000/

      Serve a specific directory with options

        $ workit -a 192.168.0.1 -p 8080 /var/www/foo
        Serving /var/www/foo at http://192.168.0.1:8080/

```

Features
--------

### Preprocessing

File extensions are taken literally. If you request jade, you'll get jade:

```

    $ curl http://localhost:3000/foo.jade
    !!! 5
    title Hello world
    link(rel='stylesheet', href='foo.css')
    script(src='/connect-reload.js')
    script(src='foo.js')

```

If you want the slightly-more-useful compiled html, request `.htm` or `.html`
instead:

```

    $ curl http://localhost:3000/foo.html
    <!DOCTYPE html><title>Hello world</title><link rel="stylesheet" href="foo.css"><script src="/connect-reload.js"></script><script src="foo.js"></script>

```

Same goes for `.coffee` vs `.js` and `.styl` vs `.css`.

### Auto-reload

To enable automatic reloading of a page when a file in your project is created
or changed, simply include the virtual `/connect-reload.js` in your markup:

```

    <!-- HTML -->
    <script src="/connect-reload.js"></script>

    // Jade
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
