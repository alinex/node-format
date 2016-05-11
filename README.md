Alinex Formatter
=================================================

[![Build Status](https://travis-ci.org/alinex/node-formatter.svg?branch=master)](https://travis-ci.org/alinex/node-formatter)
[![Coverage Status](https://coveralls.io/repos/alinex/node-formatter/badge.png?branch=master)](https://coveralls.io/r/alinex/node-formatter?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-formatter.png)](https://gemnasium.com/alinex/node-formatter)

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

[![NPM](https://nodei.co/npm/alinex-formatter.png?downloads=true&downloadRank=true&stars=true)
 ![Downloads](https://nodei.co/npm-dl/alinex-formatter.png?months=9&height=3)
](https://www.npmjs.com/package/alinex-formatter)

The easiest way is to let npm add the module directly to your modules
(from within you node modules directory):

``` sh
npm install alinex-formatter --save
```

And update it to the latest version later:

``` sh
npm update alinex-formatter --save
```

Always have a look at the latest [changes](Changelog.md).


Usage
-------------------------------------------------
To use the formatter you have to load the module first:

``` coffee
formatter = require 'alinex-formatter'
```

This gives you back the main formatter instance which holds two methods to use:

### format

Serialize data object into string.

__Arguments:__

* `obj`
  object to be formatted
* `format`
  formatter to use or filename to read format from
* `options` (optional)
  specific for the formatter
* `cb`
  callback will be called with (err, text)

### parse

Try to parse object from string. Auto detect if no format is given.

__Arguments:__

* `string`
  text to be parsed
* `format` (optional)
  formatter to use or filename to read format from
* `cb`
  callback will be called with (err, object)


Formats
-------------------------------------------------

This configuration class allows multiple formats to be used.

The following table will give a short comparison.

|  Format | Readable | Comments | Arrays | Deep | Calc |
|:--------|:--------:|:--------:|:------:|:----:|:----:|
| JSON    |    ++    |     no   |   yes  |  yes |   no |
| JS      |    ++    |    yes   |   yes  |  yes |  yes |
| CSON    |   +++    |    yes   |   yes  |  yes |   no |
| Coffee  |   +++    |    yes   |   yes  |  yes |  yes |
| YAML    |   +++    |    yes   |   yes  |  yes |   no |

Comments may be allowed but theiy get lost on reading and neither will be written.

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

``` coffee
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
```






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
  <cdata><![CDATA[i\'m not escaped: <xml>!]]></cdata>

  <!-- using attributes -->
  <attributes type="detail">
    Hello all together
  </attributes>

</xml>
```

### INI

This is one of the oldest formats used for configurations. It is very simple but
allows also complex objects through extended groups.

Common file extension `ini`.

``` ini
; put everything in a main group
[ini]
string = test

; add a simple list
list[] = 1
list[] = 2
list[] = 3

; add a sub object
[ini.person]
name = Alexander Schilling
job = Developer
```

### PROPERTIES

Mainly in the Java world properties are used to setup configuration values.
But it won't have support for arrays, you only may use objects with numbered keys.

``` properties
# put everything in a main group
prop.string = test

! add a simple list
prop.list.1 = 1
prop.list.2 = 2
prop.list.3 = 3

! add a sub object
prop.person.name : Alexander Schilling
prop.person.job: Developer
```


License
-------------------------------------------------

Copyright 2016 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
