###
YAML
==============================================
This is a simplified and best human readable language to write structured
information. See some examples at [Wikipedia](http://en.wikipedia.org/wiki/YAML).

Common file extensions `yml` or `yaml`.

__Example__

``` yaml
# null value
null: null
# boolean values
boolean: true
# include a string
string: test
unicode: "Sosa did fine.\u263A"
control: "\b1998\t1999\t2000\n"
hex esc: "\x0d\x0a is \r\n"
single: '"Howdy!" he cried.'
quoted: ' # Not a ''comment''.'
# date support
date: 2016-05-10T19:06:36.909Z
# numbers
numberInt: -8
numberFloat: 5.6
octal: 0o14
hexadecimal: 0xC
exponential: 12.3015e+02
fixed: 1230.15
negative infinity: -.inf
not a number: .NaN
# and a list of numbers
list: [one, two, three]
list2:
  - one
  - two
  - three
# add a sub object
person:
  name: Alexander Schilling
  job: Developer
# complex list with object
complex:
  - name: Egon
  - {name: Janina}
# multiline support
multiline:
  This text will be read
  as one line without
  linebreaks.
multilineQuoted: "This text will be read
  as one line without
  linebreaks."
lineBreaks: |
  This text will keep
  as it is and all line
  breaks will be kept.
lineSingle: >
  This text will be read
  as one line without
  linebreaks.
lineBreak: >
  The empty line

  will be a line break.
# regular expressions
re: !! js/regexp /\d+/
# use references
address1: &adr001
  city: Stuttgart
address2: *adr001
# specific type casts
numberString: "123"
numberString2: !!str 123
#numberFloat: !!float 123
# binary type
picture: !!binary |
  R0lGODdhDQAIAIAAAAAAANn
  Z2SwAAAAADQAIAAACF4SDGQ
  ar3xxbJ9p0qa7R0YxwzaFME
  1IAADs=
# complex mapping key
? - Detroit Tigers
  - Chicago cubs
: 2001-07-23
```

The YAML syntax is very powerful but also easy to write in it's basics:

- comments allowed starting with `#`
- dates are allowed as ISO string, too
- different multiline text entries
- special number values
- referenceswith `*xxx` to the defined '&xxx' anchor

See the example above.
###


# Node Modules
# -------------------------------------------------

# include base modules
yaml = require 'js-yaml'


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  try
    text = yaml.safeDump obj,
      schema: yaml.DEFAULT_FULL_SCHEMA
#      indent: options?.indent ? 2
  catch error
    cb new Error(
      error.message
      .replace 'JS-YAML: ', ''
      .replace /[\s^]+/g, ' '
    )
  cb null, text

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  try
    obj = yaml.safeLoad text,
      schema: yaml.DEFAULT_FULL_SCHEMA
  catch error
    return cb new Error(
      error.message
      .replace 'JS-YAML: ', ''
      .replace /[\s^]+/g, ' '
    )
  cb null, obj
