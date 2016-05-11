# Serializer for yaml syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
yaml = require 'js-yaml'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  try
    text = yaml.safeDump obj
#      indent: options?.indent ? 2
  catch error
    cb new Error(
      error.message
      .replace 'JS-YAML: ', ''
      .replace /[\s^]+/g, ' '
    )
  cb null, text


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  try
    obj = yaml.safeLoad text
  catch error
    return cb new Error(
      error.message
      .replace 'JS-YAML: ', ''
      .replace /[\s^]+/g, ' '
    )
  cb null, obj
