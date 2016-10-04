###
BSON
====================================================
Binary JSON is a more compressed version of JSON but not human readable because it's a
binary format. It is mainly used in the MongoDB database.

Common file extension `bson`.
###


# Node Modules
# -------------------------------------------------
bson = require 'bson'
BSON = new bson.BSONPure.BSON()


# Implementation
# -------------------------------------------------

# @param {Object} obj to be formatted
# @param {Object} [options] not used in this type
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, options, cb) ->
  cb null, BSON.serialize obj

# @param {String} text to be parsed
# @param {Object} [options] not used in this type
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, _, cb) ->
  try
    result = BSON.deserialize text
  catch error
    return cb error
  cb null, result
