# Serializer for json syntax
# =================================================

bson = require 'bson'
BSON = new bson.BSONPure.BSON()


# object -> string
# -------------------------------------------------
exports.stringify = (obj, options, cb) ->
  cb null, BSON.serialize obj


# string -> object
# -------------------------------------------------
exports.parse = (text, _, cb) ->
  try
    result = BSON.deserialize text
  catch error
    return cb error
  cb null, result
