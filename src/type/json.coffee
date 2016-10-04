####
# JSON
# =========================================================
#
# This format uses the javascript object notation a human readable structure. It
# is widely used in different languages not only JavaScript. See description at
# [Wikipedia](http://en.wikipedia.org/wiki/Json).
#
# Common file extension `json`.
#
# ``` json
# {
#   "null": null,
#   "boolean": true,
#   "string": "test",
#   "number": 5.6,
#   "date": "2016-05-10T19:06:36.909Z",
#   "list": [1, 2, 3],
#   "person": {
#     "name": "Alexander Schilling",
#     "job": "Developer"
#   },
#   "complex": [
#     {"name": "Egon"},
#     {"name": "Janina"}
#   ]
# }
# ```
#
# JSON's basic data types are:
#
# - Number: a signed decimal number that may contain a fractional part and may use
#   exponential E notation, but cannot include non-numbers like `NaN`.
# - String: a sequence of zero or more Unicode characters. Strings are delimited
#   with double-quotation marks and support a backslash escaping syntax.
# - Boolean: either of the values `true` or `false`
# - Array: an ordered list of zero or more values, each of which may be of any type.
#   Arrays use square bracket notation with elements being comma-separated.
# - Object: an unordered collection of name/value pairs where the keys are strings.
#   Objects are delimited with curly brackets and use commas to separate each pair,
#   while within each pair the colon ':' character separates the key or name from
#   its value.
# - Date: will be formatted as ISO string and stay as string after parsing
# - null: An empty value, using the word null
#
# Whitespace (space, horizontal tab, line feed, and carriage return) is allowed
# and ignored around or between syntactic elements.
#
# JSON won't allow comments but you may use JavaScript like comments using
# `//` and `/*...*/` like known in javascript. Therefore use the javascript
# parsing described below.
#
# __Format Options:__
#
# - `indent` - `Integer` number of spaces or text to indent each level (defaults to 2 spaces)
#
# With `indent: 0` the above example would look like:
#
# ``` json
# {"null":null,"boolean":true,"string":"test","number":5.6,"date":"2016-05-10T19:06:36.909Z",
# "list":[1,2,3],"person":{"name":"Alexander Schilling","job":"Developer"}}
# ```


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
  try
    result = JSON.parse text
  catch error
    return cb error
  cb null, result
