Alinex Format: Readme
=================================================

[![GitHub watchers](
  https://img.shields.io/github/watchers/alinex/node-format.svg?style=social&label=Watch&maxAge=2592000)](
  https://github.com/alinex/node-format/subscription)
<!-- {.hidden-small} -->
[![GitHub stars](
  https://img.shields.io/github/stars/alinex/node-format.svg?style=social&label=Star&maxAge=2592000)](
  https://github.com/alinex/node-format)
[![GitHub forks](
  https://img.shields.io/github/forks/alinex/node-format.svg?style=social&label=Fork&maxAge=2592000)](
  https://github.com/alinex/node-format)
<!-- {.hidden-small} -->
<!-- {p:.right} -->

[![npm package](
  https://img.shields.io/npm/v/alinex-format.svg?maxAge=2592000&label=latest%20version)](
  https://www.npmjs.com/package/alinex-format)
[![latest version](
  https://img.shields.io/npm/l/alinex-format.svg?maxAge=2592000)](
  #license)
<!-- {.hidden-small} -->
[![Travis status](
  https://img.shields.io/travis/alinex/node-format.svg?maxAge=2592000&label=develop)](
  https://travis-ci.org/alinex/node-format)
[![Coveralls status](
  https://img.shields.io/coveralls/alinex/node-format.svg?maxAge=2592000)](
  https://coveralls.io/r/alinex/node-format?branch=master)
[![Gemnasium status](
  https://img.shields.io/gemnasium/alinex/node-format.svg?maxAge=2592000)](
  https://gemnasium.com/alinex/node-format)
[![GitHub issues](
  https://img.shields.io/github/issues/alinex/node-format.svg?maxAge=2592000)](
  https://github.com/alinex/node-format/issues)
<!-- {.hidden-small} -->


This package will give you an easy way to serialize and deserialize different data
objects into multiple formats.

The major features are:

- easy to use
- load format libraries on demand
- auto detection

> It is one of the modules of the [Alinex Namespace](https://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](https://alinex.github.io/develop).

__Read the complete documentation under
[https://alinex.github.io/node-format](https://alinex.github.io/node-format).__
<!-- {p: .hidden} -->


Install
-------------------------------------------------

[![NPM](https://nodei.co/npm/alinex-format.png?downloads=true&downloadRank=true&stars=true)
 ![Downloads](https://nodei.co/npm-dl/alinex-format.png?months=9&height=3)
](https://www.npmjs.com/package/alinex-format)

The easiest way is to let npm add the module directly to your modules
(from within you node modules directory):

``` sh
npm install alinex-format --save
```

And update it to the latest version later:

``` sh
npm update alinex-format --save
```

Always have a look at the latest [changes](Changelog.md).


Usage
-------------------------------------------------
To use the format you have to load the module first:

``` coffee
format = require 'alinex-format'
```

This gives you back the main format instance which holds two methods to use:

### stringify

Serialize data object into string.

__Arguments:__

* `obj`
  object to be formatted
* `format`
  format to use or filename to read format from
* `options` (optional)
  specific for the format
* `cb`
  callback will be called with (err, text)

### parse

Try to parse object from string. Auto detect if no format is given.

__Arguments:__

* `string`
  text to be parsed
* `format` (optional)
  format to use or filename to read format from
* `cb`
  callback will be called with (err, object)


License
-------------------------------------------------

(C) Copyright 2016 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
