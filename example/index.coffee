symfio = require "symfio"
nodefn = require "when/node/function"

module.exports = container = symfio "example", __dirname

container.use require "symfio-contrib-winston"
container.use require "symfio-contrib-express"
container.use require ".."

container.use (container, model, get) ->
  model "Fruit", "fruits", (mongoose) ->
    new mongoose.Schema
      name: String

  get "/", (Fruit) ->
    (req, res) ->
      Fruit.findOne (err, fruit) ->
        return res.send 500 if err
        return res.send 404 unless fruit
        res.send fruit

  container.call (Fruit) ->
    fruit = new Fruit name: "Apple"
    nodefn.call fruit.save.bind fruit

container.load() if require.main is module
