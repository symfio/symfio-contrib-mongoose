mongoose = require "mongoose"


module.exports = (container, callback) ->
  unloader = container.get "unloader"
  logger = container.get "logger"
  name = container.get "name"

  logger.info "loading plugin", "contrib-mongoose"

  connection = mongoose.createConnection()

  container.set "connection", connection
  container.set "mongoose", mongoose
  container.set "mongodb", mongoose.mongo

  connectionString = container.get "connection string",
    process.env.MONGOHQ_URL or "mongodb://localhost/#{name}"

  connection.open connectionString, (err) ->
    logger.error err if err
    callback()

  unloader.register (callback) ->
    return callback() unless connection.readyState is 1

    connection.close ->
      callback()
