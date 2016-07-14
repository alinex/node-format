Alinex Format
=================================================

[![Build Status](https://travis-ci.org/alinex/node-format.svg?branch=master)](https://travis-ci.org/alinex/node-format)
[![Coverage Status](https://coveralls.io/repos/alinex/node-format/badge.png?branch=master)](https://coveralls.io/r/alinex/node-format?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-format.png)](https://gemnasium.com/alinex/node-format)

This package will give you an easy way to serialize and deserialize different data
objects into multiple formats.

The major features are:

- easy to use
- load format libraries on demand
- auto detection

> It is one of the modules of the [Alinex Universe](http://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](http://alinex.github.io/develop).


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


Formats
-------------------------------------------------

This configuration class allows multiple formats to be used.

The following table will give a short comparison.

|  Format | Readable | Comments | Arrays | Deep | Calc | Ref. |
|:--------|:--------:|:--------:|:------:|:----:|:----:|:----:|
| JSON    |    ++    |     no   |   yes  |  yes |   no |   no |
| JS      |    ++    |  allow   |   yes  |  yes | read |   no |
| CSON    |   +++    |  allow   |   yes  |  yes |   no |   no |
| Coffee  |   +++    |  allow   |   yes  |  yes | read |   no |
| YAML    |   +++    |  allow   |   yes  |  yes |   no | read |
| INI     |    ++    |  allow   |   yes  |  yes |   no |   no |
| Properties | ++    |  allow   |   yes  |  yes |   no | read |
| XML     |     +    |  allow   |   yes  |  yes |   no |   no |
| BSON    |    --    |     no   |   yes  |  yes |   no |   no |
| CSV     |     +    |    (no)  |   yes  | (yes)|   no |   no |

Legend: +++ to --- = good to bad; no = not possible; allow = allowed but unused;
read = only red but not written; write = only written but not red; yes = fully
supported; ? = unknown

See details for each format below.

Some of the formats support comments but they won't read or write them, they
only will allow them to be there in the file.

### JSON

This format uses the javascript object notation a human readable structure. It
is widely used in different languages not only JavaScript. See description at
[Wikipedia](http://en.wikipedia.org/wiki/Json).

Common file extension `json`.

``` json
{
  "null": null,
  "boolean": true,
  "string": "test",
  "number": 5.6,
  "date": "2016-05-10T19:06:36.909Z",
  "list": [1, 2, 3],
  "person": {
    "name": "Alexander Schilling",
    "job": "Developer"
  },
  "complex": [
    {"name": "Egon"},
    {"name": "Janina"}
  ]
}
```

JSON's basic data types are:

- Number: a signed decimal number that may contain a fractional part and may use
  exponential E notation, but cannot include non-numbers like `NaN`.
- String: a sequence of zero or more Unicode characters. Strings are delimited
  with double-quotation marks and support a backslash escaping syntax.
- Boolean: either of the values `true` or `false`
- Array: an ordered list of zero or more values, each of which may be of any type.
  Arrays use square bracket notation with elements being comma-separated.
- Object: an unordered collection of name/value pairs where the keys are strings.
  Objects are delimited with curly brackets and use commas to separate each pair,
  while within each pair the colon ':' character separates the key or name from
  its value.
- Date: will be formatted as ISO string and stay as string after parsing
- null: An empty value, using the word null

Whitespace (space, horizontal tab, line feed, and carriage return) is allowed
and ignored around or between syntactic elements.

JSON won't allow comments but you may use JavaScript like comments using
`//` and `/*...*/` like known in javascript. Therefore use the javascript
parsing described below.

__Format Options:__

- `indent` - number of spaces or text to indent each level (defaults to 2 spaces)

With `indent: 0` the above example would look like:

``` json
{"null":null,"boolean":true,"string":"test","number":5.6,"date":"2016-05-10T19:06:36.909Z","list":[1,2,3],"person":{"name":"Alexander Schilling","job":"Developer"}}
```

### JavaScript

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

- `indent` - number of spaces or text to indent each level (defaults to 2 spaces)

### CSON

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
  Livestock and their byproducts account for at least 32,000 million tons of carbon dioxide (CO2) per year, or 51% of all worldwide greenhouse gas emissions.
  Goodland, R Anhang, J. “Livestock and Climate Change: What if the key actors in climate change were pigs, chickens and cows?”
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

- `indent` - number of spaces or text to indent each level (defaults to 2 spaces)

### Coffee

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
  Livestock and their byproducts account for at least 32,000 million tons of carbon dioxide (CO2) per year, or 51% of all worldwide greenhouse gas emissions.
  Goodland, R Anhang, J. “Livestock and Climate Change: What if the key actors in climate change were pigs, chickens and cows?”
  WorldWatch, November/December 2009. Worldwatch Institute, Washington, DC, USA. Pp. 10–19.
  http://www.worldwatch.org/node/6294
  '''
# calculate session timeout in milliseconds
calc: 15*60*1000
math: Math.sqrt 16
```

__Format Options:__

- `indent` - number of spaces or text to indent each level (defaults to 2 spaces)

### YAML

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

### INI

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

- `whitespace` - (boolean) should spaces be put arround `=` (defaults to true)

### PROPERTIES

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

### XML

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

- `root` - (string) name of the root element (default: 'xml')

__Parse Options:__

- `explicitRoot` - (boolean) keep the root element (default: false)
- `ignoreAttrs` - (boolean) ignore attribute settings (default: false)


### BSON

Binary JSON is a more compressed version of JSON but not human readable because it's a
binary format. It is mainly used in the MongoDB database.

Common file extension `bson`.

### CSV

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

- `columns` List of fields, applied when transform returns an object, order matters, read the transformer documentation for additionnal information, columns are auto discovered in the first record when the user write objects, can refer to nested properties of the input JSON, see the "header" option on how to print columns names on the first line.
- `delimiter` Set the field delimiter (default: ';')
- `escape` - (char) Set the escape character (Default: '"')
- `quote` - (char) Optionnal character surrounding a field, one character only (Default: '"')
- `quoted` - (boolean) quote all the non-empty fields even if not required (default: false)
- `quotedEmpty` - (boolean) quote empty fields? (default: false)
- `quotedString` - (boolean) quote all fields of type string even if not required (default: false)

__Parse Options:__

- `delimiter` - (char) Set the field delimiter (default: ';')
- `quote` - (char) Optionnal character surrounding a field, one character only (Default: '"')
- `escape` - (char) Set the escape character (Default: '"')
- `comment` - (char) Treat all the characters after this one as a comment, default to '' (disabled).


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
