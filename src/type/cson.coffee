# Serializer for js syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
js2coffee = null # load on demand
coffee = null # load on demand


# object -> string
# -------------------------------------------------
exports.format = (obj, _, cb) ->
  js2coffee ?= require 'js2coffee'
  cb null, js2coffee.build("(#{JSON.stringify obj})").code\
  .replace /(^|\n\s*)'([a-zA-Z0-9]+)':/g, '$1$2:'


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  coffee ?= require 'coffee-script'
  try
    text = "module.exports =\n  " + text.replace /\n/g, '\n  '
    m = new module.constructor()
    m._compile coffee.compile(text), 'object.cson'
  catch error
    return cb error
  cb null, m.exports
