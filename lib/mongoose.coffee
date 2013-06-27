mongoose = require "mongoose"
w = require "when"


module.exports = (container, connectionString, name = "test") ->
  container.set "mongoose", mongoose
  container.set "mongodb", mongoose.mongo

  unless connectionString
    container.set "connectionString", "mongodb://localhost/#{name}"

  container.set "connection", (connectionString, mongoose) ->
    deffered = w.defer()

    connection = mongoose.createConnection()
    connection.open connectionString, (err) ->
      return deffered.reject err if err
      deffered.resolve connection

    deffered.promise

  container.set "model", (container) ->
    (name, collectionName, factory) ->
      container.set name, (connection) ->
        container.call(factory).then (schema) ->
          container.set "#{name}Schema", schema
          connection.model collectionName, schema
