// Released into the Public Domain by tav <tav@espians.com>

/*global phantom, $, document, asciinema, callPhantom*/

var system = require('system'),
  webpage = require('webpage');

var argv, dims, failure, init, next;

// Get the command line arguments.
argv = system.args;

if (argv.length === 1) {
  console.log('Usage: render.js URL [FRAMES_PER_SECOND]');
  phantom.exit(0);
}

// Utility function to ensure a page load succeeded.
function checkStatus(status) {
  if (status !== 'success') {
    console.log("ERROR: Couldn't open " + argv[1] + '.');
    console.log('ERROR: ' + failure);
    phantom.exit(1);
  }
}

// Capture any resource errors when loading pages.
function newPage() {
  var page = webpage.create();
  page.onResourceError = function (err) {
    failure = err.errorString;
  };
  // Uncomment this to see console.log calls from within pages.
  // page.onConsoleMessage = function (info) {
  //   console.log(info);
  // };
  return page;
}

// Do a first pass to detect the exact dimensions of the asciicast.
init = newPage();
init.viewportSize = { width: 9999, height: 9999 };
init.open(argv[1], function (status) {
  checkStatus(status);
  dims = init.evaluate(function () {
    var term = $('.asciinema-terminal');
    return [term.width(), term.height()];
  });

  console.log('>> Dimensions: ' + dims[0] + 'x' + dims[1]);

  next = newPage();
  next.viewportSize = { width: dims[0], height: dims[1] };
  next.open(argv[1], function (status) {
    var diff,
      frame = 1,
      framerate = argv[2] ? parseInt(argv[2], 10) : 10,
      interval = 1000 / framerate,
      last = 0,
      stop = false;

    checkStatus(status);

    next.onCallback = function (running, progress) {
      if (progress !== undefined) {
        console.log('>> Progress: ' + progress);
        return;
      }
      if (running) {
        console.log('>> Generating screenshots ...');
        var now = Date.now();
        setTimeout(function screenshot() {
          if (stop) {
            console.log('>> Done!');
            phantom.exit(0);
            return;
          }
          next.render('frames/' + ('00000000' + frame++).substr(-8, 8) + '.png', { format: 'png' });
          now = Date.now();
          if ((diff = interval - now - last) <= 0) {
            setTimeout(screenshot, 0);
          } else {
            setTimeout(screenshot, diff);
          }
          last = now;
        }, interval);
      } else {
        stop = true;
      }
    };

    console.log('>> Preparing window ...');
    next.evaluate(function () {
      var fetch, ev, el;
      // Hide the control bar and the powered by paragraph.
      $('.control-bar').hide();
      $('.powered').hide();
      // Change the styling slightly.
      $('<style>.asciinema-player-wrapper{text-align: left}</style>').appendTo(document.body);
      // Intercept the data load.
      fetch = asciinema.HttpArraySource.prototype.fetchData;
      asciinema.HttpArraySource.prototype.fetchData = function (setLoading, onResult) {
        fetch.call(this, setLoading, function () {
          // Initialise the player.
          onResult();
          // Start the screenshots.
          callPhantom(true);
          // Check if the player has finished.
          var prev = '',
            sameCount = 0;
          setTimeout(function checkProgress() {
            var width = $('.gutter')[0].children[0].style.width;
            if (width === prev) {
              sameCount += 1;
              if (sameCount === 3) {
                callPhantom(false);
                return;
              }
            } else {
              callPhantom(true, width);
              sameCount = 0;
            }
            prev = width;
            setTimeout(checkProgress, 100);
          }, 0);
        });
      };
      // Synthesise the click for playing the video.
      el = $('.start-prompt')[0];
      ev = document.createEvent('Events');
      ev.initEvent('click', true, false);
      // ev = new CustomEvent('click', {bubbles: true});
      el.dispatchEvent(ev);
    });
  });
});
