# Serializer for js syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
vm = null # load on demand


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
  vm ?= require 'vm'
  try
    result = vm.runInNewContext "x=#{text}"
  catch error
    return cb error
  cb null, result
