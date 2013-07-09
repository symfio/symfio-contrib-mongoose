module.exports = (container) ->
  container.require "mongoose"

  container.unless "connectionString", (name) ->
    "mongodb://localhost/#{name}"

  container.set "mongodb", (mongoose) ->
    mongoose.mongo

  container.set "connection", (logger, connectionString, mongoose, w) ->
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
        container.inject(factory).then (schema) ->
          container.set "#{name}Schema", schema
          connection.model collectionName, schema
