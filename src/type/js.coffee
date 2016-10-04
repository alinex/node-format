###
JavaScript
=======================================================

Also allowed are normal JavaScript files. In comparison to the JSON format it
is more loosely so you may use single quotes, keys don't need quotes at all and
at last you may use calculations. But you may only access elements in the same
file accessing data from outside is prevented by security.

Common file extension `js`.

``` javascript
// use an object
{
  // null value
  null: null,
  // boolean setting
  boolean: true,
  // include a string
  string: 'test',
  // any integer or float number
  number: 5.6,
  // a date as string
  date: "2016-05-10T19:06:36.909Z",
  // and a list of numbers
  list: [1, 2, 3],
  // add a sub object
  person: {
    name: "Alexander Schilling",
    job: "Developer"
  },
  // complex list with object
  complex: [
    {name: 'Egon'},
    {name: 'Janina'}
  ],
  // calculate session timeout in milliseconds
  calc: 15*60*1000,
  math: Math.sqrt(16)
}
```

__Format Options:__

- `indent` - `Integer` number of spaces or text to indent each level (defaults to 2 spaces)
###


# Node Modules
# -------------------------------------------------

# include base modules
vm = null # load on demand


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  cb null, JSON.stringify obj, null, options?.indent ? 2

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  vm ?= require 'vm'
  try
    result = vm.runInNewContext "x=#{text}"
  catch error
    return cb error
  cb null, result
