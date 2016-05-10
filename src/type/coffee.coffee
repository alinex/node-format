# Serializer for js syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
coffee = require 'coffee-script'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  try
    text = "module.exports =\n  " + text.replace /\n/g, '\n  '
    m = new module.constructor()
    m._compile coffee.compile(text), 'object.cson'
  catch error
    return cb error
  cb null, m.exports
