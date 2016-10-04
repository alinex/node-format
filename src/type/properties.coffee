###
Properties
==============================================================
Mainly in the Java world properties are used to setup configuration values.
But it won't have support for arrays, you only may use objects with numbered keys.

Common file extension `properties`.

``` properties
# strings
string = test
other text
multiline This text \
  goes over multiple lines.

# numbers
integer = 15
float: -4.6

! add a simple list
list.1 = one
list.2 = two
list.3 = three

! add a sub object
person.name: Alexander Schilling
person.job: Developer

#references
ref = ${string}

# add a section
[section]
name = Alex
same = ${section|name}
```

This format supports:

- key and value may be divided by `=`, `:` with spaces or only a space
- comments start with `!` or `#`
- structure data using sections with square brackets like in ini files
- structure data using namespaces in the key using dot as seperator
- references to other values with `${key}`
- references work also as section names or reference name
###


# Node Modules
# -------------------------------------------------

# include base modules
properties = require 'properties'


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] not used in this type
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, _, cb) ->
  try
    text = properties.stringify flatten(obj),
      unicode: true
  catch error
    return cb error if error
  cb null, text

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  properties.parse text.toString(),
    sections: true
    namespaces: true
    variables: true
  , (err, result) ->
    return cb err if err
    unless propertiesCheck result
      return cb new Error "Unexpected characters []{}/ in key name found"
    cb null, optimizeArray result


# Helper
# -------------------------------------------------

# @param {Object} data parsed data to check
# @return {Boolean} true if no parsing errors are included
propertiesCheck = (data) ->
  return true unless typeof data is 'object'
  for k, v of data
    if v is null or ~'[]{}/'.indexOf k.charAt 0
      return false
    return false unless propertiesCheck v
  return true

# @param {Object} obj deep structure
# @return flat structure
flatten = (obj) ->
  return obj unless typeof obj is 'object'
  flat = {}
  # recursive flatten
  for key, value of obj
    unless typeof value is 'object'
      flat[key] = value
    else
      for k, v of flatten value
        flat["#{key}.#{k}"] = v
  return flat

# @param {Object} obj to convert to array if possible
# @return {Object|Array} optimized structure
optimizeArray = (obj) ->
  return obj unless typeof obj is 'object'
  # recursive work further
  for key, value of obj
    obj[key] = optimizeArray value
  # replace with array if possible
  keys = Object.keys obj
  keys.sort()
  if keys.join(',') is [0..keys.length-1].join(',')
    list = []
    list.push obj[k] for k in keys
    obj = list
  obj
