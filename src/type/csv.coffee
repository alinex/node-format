###
CSV
=======================================================
The CSV format should only be used with table like data which is in the form of
a list of lists. See the [table](http://alinex.github.io/node-table) package to
transform and work with such data.

Autodetection is not possible here.

Common file extension `csv`.

``` csv
num;type;object
1;null;
2;undefined;
3;boolean;1
4;number;5.6
5;text;Hello
6;quotes;"Give me a ""hand up"""
7;date;128182440000
8;list;[1,2,3]
9;object;"{""name"":""Egon""}"
10;complex;"[{""name"":""Valentina""},{""name"":""Nadine""},{""name"":""Sven""}]"
```

While some types are fully supported: string, number

Others are partly supported and won't be automatically detectable:

- boolean as integer
- date as unix time integer
- null, undefined and empty strings are stored the same way and wil be red as null

And lastly complex sub objects will be stored as JSON text and be automatically
parsed on read again.

__Format Options:__

- `columns` - `Array` List of fields, applied when transform returns an object,
order matters, columns are auto discovered in the first record
- `delimiter` - `String` Set the field delimiter (default: ';')
- `escape` - `String` Set the escape character (Default: '"')
- `quote` - `String` Optionnal character surrounding a field, one character only (Default: '"')
- `quoted` - `Boolean` quote all the non-empty fields even if not required (default: false)
- `quotedEmpty` - `Boolean` quote empty fields? (default: false)
- `quotedString` - `Boolean` quote all fields of type string even if not required (default: false)

__Parse Options:__

- `delimiter` - `String` Set the field delimiter (default: ';')
- `quote` - `String` Optionnal character surrounding a field, one character only (Default: '"')
- `escape` - `String` Set the escape character (Default: '"')
- `comment` - `String` Treat all the characters after this one as a comment, default to ''
(disabled).
###


# Node Modules
# -------------------------------------------------
parser = null # load on demand
stringifyer = null # load on demand


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] format options like described above
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  obj = obj.data if obj.data
  stringifyer ?= require 'csv-stringify'
  stringifyer obj,
    columns: options?.columns
    delimiter: options?.delimiter ? ';'
    quote: options?.quote ? '"'
    escape: options?.escape ? '"'
    header: true
    quoted: options?.quoted ? false
    quotedEmpty: options?.quotedEmpty ? false
    quotedString: options?.quotedString ? false
  , cb

# @param {String} text to be parsed
# @param {Object} [options] parse options like described above
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, options, cb) ->
  parser ?= require 'csv-parse'
  parser text,
    delimiter: options?.delimiter ? ';'
    quote: options?.quote ? '"'
    escape: options?.escape ? '"'
    comment: options?.comment ? ''
    auto_parse: true
    auto_parse_date: true
  , (err, obj) ->
    return cb err if err
    # optimize objects from json
    cb null, obj.map (line) ->
      line.map (field) ->
        return null if field is ''
        return field unless typeof field is 'string' and field[0] in ['[', '{']
        try
          result = JSON.parse field
        catch
          return field
        result
