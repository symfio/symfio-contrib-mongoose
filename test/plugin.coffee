suite = require "symfio-suite"


describe "contrib-mongoose()", ->
  it = suite.plugin [
    require ".."
  ]

  it "should generate connection string using name value", (connectionString) ->
    connectionString.should.equal "mongodb://localhost/test"
