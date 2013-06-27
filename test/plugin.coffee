symfio = require "symfio"
plugin = require ".."
chai = require "chai"


describe "contrib-mongoose plugin", ->
  chai.use require "chai-as-promised"
  chai.should()

  container = symfio "example", __dirname
  container.use plugin

  before (callback) ->
    container.load().should.notify callback

  it "should generate connection string using name value", (callback) ->
    container.get("connectionString").then (connectionString) ->
      connectionString.should.equal "mongodb://localhost/example"
    .should.notify callback
