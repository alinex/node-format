# Serializer for json syntax
# =================================================


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  # default settings
  options ?=
    indent: 2
  cb null, JSON.stringify obj, null, options?.indent

# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  try
    result = JSON.parse text
  catch error
    return cb error
  cb null, result
