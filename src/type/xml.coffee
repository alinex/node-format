###
XML
======================================================
The XML format should only use Tags and values, but no arguments.

Common file extension `xml`.

``` xml
<?xml version="1.0" encoding="UTF-8" ?>
<!-- use an object -->
<xml>

  <!-- include a string -->
  <name>test</name>

  <!-- and a list of numbers -->
  <list>1</list>
  <list>2</list>
  <list>3</list>

  <!-- sub object -->
  <person>
    <name>Alexander Schilling</name><job>Developer</job>
  </person>

  <!-- cdata section -->
  <cdata><![CDATA[i'm not escaped: <xml>!]]></cdata>

  <!-- using attributes -->
  <attributes type="detail">
    Hello all together
    <sub>And specially you!</sub>
  </attributes>

</xml>
```

__Format Options:__

- `root` - `String` name of the root element (default: 'xml')

__Parse Options:__

- `explicitRoot` - `Boolean` keep the root element (default: false)
- `ignoreAttrs` - `Boolean` ignore attribute settings (default: false)
###


# Node Modules
# -------------------------------------------------
xml2js = require 'xml2js'


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  builder = new xml2js.Builder()
  try
    text = builder.buildObject obj,
#      charkey: 'value'
      rootName: options?.root ? 'xml'
      cdata: true
  catch error
    return cb error
  cb null, text

# @param {String} text to be parsed
# @param {Object} [options] parse options like described above
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, options, cb) ->
  xml2js.parseString text,
    explicitRoot: options?.explicitRoot ? false
    explicitArray: false
    trim: true
    emptyTag: null
    ignoreAttrs: options?.ignoreAttrs
    mergeAttrs: true
    preserveChildrenOrder: true
#    charkey: 'value'
  , (err, result) ->
    if err
      return cb new Error err.message.replace /\n/g, ' '
    # optimize result of attributes
    cb null, result
