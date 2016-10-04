###
Coffee
=====================================================
The Coffee Script format is nearly the same as CSON but caused by the changed
parser it may contain calculations, too.

Common file extension `coffee`.

``` coffee
null: null
boolean: true
# include a string
string: 'test'
number: 5.6
date: '2016-05-10T19:06:36.909Z'
# and a list of numbers
list: [
  1
  2
  3
]
# add a sub object
person:
  name: 'Alexander Schilling'
  job: 'Developer'
# complex structure
complex: [
  {name: 'Egon'}
  {name: 'Janina'}
]
# Multi-Line Strings! Without Quote Escaping!
emissions: '''
  Livestock and their byproducts account for at least 32,000 million tons of carbon
  dioxide (CO2) per year, or 51% of all worldwide greenhouse gas emissions.
  Goodland, R Anhang, J. “Livestock and Climate Change: What if the key actors in
  climate change were pigs, chickens and cows?”
  WorldWatch, November/December 2009. Worldwatch Institute, Washington, DC, USA. Pp. 10–19.
  http://www.worldwatch.org/node/6294
  '''
# calculate session timeout in milliseconds
calc: 15*60*1000
math: Math.sqrt 16
```

__Format Options:__

- `indent` - `Integer` number of spaces or text to indent each level (defaults to 2 spaces)
###


# Node Modules
# -------------------------------------------------
coffee = null # load on demand
CSON = null # load on demand


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  CSON ?= require 'cson-parser'
  cb null, CSON.stringify obj, null, options?.indent ? 2

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  coffee ?= require 'coffee-script'
  try
    text = "module.exports =\n  " + text.replace /\n/g, '\n  '
    m = new module.constructor()
    m._compile coffee.compile(text), 'inline.coffee'
  catch error
    return cb error
  cb null, m.exports
