w = require "when"


module.exports = (container, connectionString, name = "test") ->
  container.set "mongoose", (logger) ->
    logger.debug "require module", name: "mongoose"
    require "mongoose"

  container.set "mongodb", (mongoose) ->
    mongoose.mongo

  container.set "connection", (logger, connectionString, mongoose) ->
    logger.info "connect to mongodb", connectionString: connectionString

    deffered = w.defer()

    connection = mongoose.createConnection()
    connection.open connectionString, (err) ->
      return deffered.reject err if err
      deffered.resolve connection

    deffered.promise

  container.set "model", (container, logger) ->
    (name, collectionName, factory) ->
      logger.debug "define mongoose model", name: name

      container.set name, (connection) ->
        container.call(factory).then (schema) ->
          container.set "#{name}Schema", schema
          connection.model collectionName, schema


  unless connectionString
    container.set "connectionString", "mongodb://localhost/#{name}"
