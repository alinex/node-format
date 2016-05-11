# Serializer for js syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
coffee = null # load on demand
CSON = null # load on demand


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  CSON ?= require 'cson-parser'
  cb null, CSON.stringify obj, null, options?.indent ? 2


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  coffee ?= require 'coffee-script'
  try
    text = "module.exports =\n  " + text.replace /\n/g, '\n  '
    m = new module.constructor()
    m._compile coffee.compile(text), 'inline.coffee'
  catch error
    return cb error
  cb null, m.exports
