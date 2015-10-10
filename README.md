# jekyll-typeset

> [Typeset.js](https://blot.im/typeset/) plugin for Jekyll.


## Install

1. Install Typeset:

    `npm install typeset`

2. Download `jekyll-typeset.rb` and place it in the `_plugins` directory of your Jekyll site.


## Usage

By default, jekyll-typeset will process the entire rendered HTML output of your posts and pages. You can narrow its scope in your Jekyll site's `_config.yml`:

    typeset:
      only: '.post-content'
      ignore: '.ignore'

Refer to the Typeset.js documentation for [detailed options usage](https://github.com/davidmerfield/typeset#options).


## Caveats

`jekyll-typeset` isn't exactly, uh, *fast*. If you're using a build system with Jekyll, you'll probably be happier with [gulp-typeset](https://github.com/lucasconstantino/gulp-typeset) or [grunt-typeset](https://github.com/mobinni/grunt-typeset).
