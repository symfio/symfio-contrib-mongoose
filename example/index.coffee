symfio = require "symfio"

module.exports = container = symfio "example", __dirname
loader = container.get "loader"

loader.use require "symfio-contrib-express"
loader.use require "../lib/mongoose"

loader.use (container, callback) ->
  connection = container.get "connection"
  mongoose = container.get "mongoose"
  unloader = container.get "unloader"
  app = container.get "app"

  FruitSchema = new mongoose.Schema
    name: String

  Fruit = connection.model "fruits", FruitSchema

  fruit = new Fruit name: "Apple"
  fruit.save ->
    callback()

  app.get "/", (req, res) ->
    Fruit.findOne (err, fruit) ->
      return res.send 500 if err
      return res.send 404 unless fruit
      res.send fruit

  unloader.register (callback) ->
    connection.db.dropDatabase ->
      callback()

loader.load() if require.main is module
