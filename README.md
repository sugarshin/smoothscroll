# smoothscroll

[![Build Status](https://travis-ci.org/sugarshin/smoothscroll.svg?branch=master)](https://travis-ci.org/sugarshin/smoothscroll) [![Coverage Status](https://coveralls.io/repos/sugarshin/smoothscroll/badge.svg)](https://coveralls.io/r/sugarshin/smoothscroll) [![GitHub version](https://badge.fury.io/gh/sugarshin%2Fsmoothscroll.svg)](http://badge.fury.io/gh/sugarshin%2Fsmoothscroll) [![License](http://img.shields.io/:license-mit-blue.svg)](http://sugarshin.mit-license.org/)

SmoothScroll

## Usage

```coffeescript
SmoothScroll = require 'smoothscroll'

new SmoothScroll el, opts
```

## Config

default options

```js
var options = {
  speed: 700,
  easingName: null,
  offset: 0,
  onScrollBefore: function(el) {},
  onScrollAfter: function(el) {}
};
```

## Contributing

```shell
npm test
```

**incomplete**

## License

[MIT](http://sugarshin.mit-license.org/)

© sugarshin
