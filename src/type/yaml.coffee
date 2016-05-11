# Serializer for yaml syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
yaml = require 'js-yaml'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  try
    result = yaml.safeLoad text
  catch error
    error.message = error.message.replace 'JS-YAML: ', ''
    return cb new Error(
      error.message
      .replace 'JS-YAML: ', ''
      .replace /[\s^]+/g, ' '
    )
  cb null, result
