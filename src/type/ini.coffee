###
INI
===================================================
This is one of the oldest formats used for configurations. It is very simple but
allows also complex objects through extended groups.

Common file extension `ini`.

``` ini
; simple text
string = test

; add a simple list
list[] = 1
list[] = 2
list[] = 3

; add a group
[person]
name = Alexander Schilling
job = Developer

; add a subgroup
[city.address]
name = Stuttgart
```

Comments start with semicolon and grous/sections are marked by square brackets.
The group name defines the object to add the properties to.

__Format Options:__

- `whitespace` - `Boolean` should spaces be put arround `=` (defaults to true)
###


# Node Modules
# -------------------------------------------------

# include base modules
ini = require 'ini'


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  try
    text = ini.encode obj,
      whitespace: if options?.whitespace? then options.whitespace else true
  catch error
    return cb error
  cb null, text

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  try
    result = ini.decode text
  catch error
    return cb error
  # detect failed parsing
  unless result? and Object.keys(result).length
    return cb new Error "could not parse any result"
  if result['{']
    return cb new Error "Unexpected token { at start"
  for k, v of result
    if v is true and k.match /:/
      return cb new Error "Unexpected key name containing ':' with value true"
  cb null, result
