symfio = require "symfio"
nodefn = require "when/node/function"
w = require "when"

module.exports = container = symfio "example", __dirname

module.exports.promise = container.injectAll [
  require "symfio-contrib-winston"
  require "symfio-contrib-express"
  require ".."

  (container, model, get) ->
    model "Fruit", "fruits", (mongoose) ->
      new mongoose.Schema
        name: String

    get "/", (Fruit) ->
      (req, res) ->
        Fruit.find (err, fruits) ->
          return res.send 500 if err
          return res.send 404 unless fruits
          res.send fruits

    container.inject (connection, Fruit) ->
      deffered = w.defer()

      connection.db.dropDatabase ->
        deffered.resolve()

      deffered.promise.then ->
        fruit = new Fruit name: "Apple"
        nodefn.call fruit.save.bind fruit
]


if require.main is module
  module.exports.promise.then ->
    container.get "startExpressServer"
  .then (startExpressServer) ->
    startExpressServer()
