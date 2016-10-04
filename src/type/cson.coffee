###
CSON
======================================

Like JSON but here the object is defined using CoffeeScript instead of javascript.

Common file extension `cson`.

``` cson
# null value
null: null
# boolean values
boolean: true
# include a string
string: 'test'
date: '2016-05-10T19:06:36.909Z'
# numbers
numberInt: -8
numberFloat: 5.6
# and a list of numbers
list: [1, 2, 3]
list2: [
  1
  2
  3
]
# add a sub object
person:
  name: 'Alexander Schilling'
  job: 'Developer'
# complex list with object
complex: [
  name: 'Egon'
,
  name: 'Janina'
]
# Multi-Line Strings! Without Quote Escaping!
emissions: '''
  Livestock and their byproducts account for at least 32,000 million tons of
  carbon dioxide (CO2) per year, or 51% of all worldwide greenhouse gas emissions.
  Goodland, R Anhang, J. “Livestock and Climate Change: What if the key actors in
  climate change were pigs, chickens and cows?”
  WorldWatch, November/December 2009. Worldwatch Institute, Washington, DC, USA. Pp. 10–19.
  http://www.worldwatch.org/node/6294
  '''
```

CSON solves several major problems with hand-writing JSON by providing:

- the ability to use both single-quoted and double-quoted strings
- the ability to write multi-line strings in multiple lines
- the ability to write a redundant comma
- comments start with `#` and are allowed

Besides this facts it's the same as JSON and have the same types.

__Format Options:__

- `indent` - `Integer` number of spaces or text to indent each level (defaults to 2 spaces)
###


# Node Modules
# -------------------------------------------------
CSON = require 'cson-parser'


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  cb null, CSON.stringify obj, null, options?.indent ? 2

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  try
    result = CSON.parse text
  catch error
    return cb error
  cb null, result
