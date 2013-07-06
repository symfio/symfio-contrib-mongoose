symfio = require "symfio"
chai = require "chai"


describe "contrib-mongoose()", ->
  chai.use require "chai-as-promised"
  chai.should()

  container = symfio "test", __dirname
  container.inject require ".."

  it "should generate connection string using name value", (callback) ->
    container.get("connectionString").then (connectionString) ->
      connectionString.should.equal "mongodb://localhost/test"
    .should.notify callback
