suite = require "symfio-suite"


describe "contrib-mongoose()", ->
  it = suite.plugin (container, containerStub) ->
    require("..") containerStub

    container.set "connection", (sandbox) ->
      connection =
        open: sandbox.stub()
        model: sandbox.stub()
      connection.open.yields()
      connection

    container.set "mongoose", (sandbox, connection) ->
      mongoose = createConnection: sandbox.stub()
      mongoose.createConnection.returns connection
      mongoose

  describe "container.unless connectionString", ->
    it "should generate connection string using name value",
      (containerStub) ->
        factory = containerStub.unless.get "connectionString"
        factory("test").should.equal "mongodb://localhost/test"

  describe "container.set mongoose", ->
    it "should define", (containerStub) ->
      containerStub.set.should.be.calledWith "mongoose"

  describe "container.set mongodb", ->
    it "should define", (containerStub) ->
      containerStub.set.should.be.calledWith "mongodb"

  describe "container.set connection", ->
    it "should connect", (containerStub, logger, mongoose, connection) ->
      factory = containerStub.set.get "connection"
      factory logger, "connectionString", mongoose
      connection.open.should.be.calledOnce
      connection.open.should.be.calledWith "connectionString"

  describe "container.set model", ->
    it "should define model", (containerStub, logger, connection) ->
      factory = containerStub.set.get "model"
      model = factory containerStub, logger
      model "Model", "collection", "factory"
      modelFactory = containerStub.set.get "Model"
      modelFactory connection
      containerStub.inject.promise.then.yield "schema"
      containerStub.inject.should.be.calledWith "factory"
      containerStub.set.get("ModelSchema").should.equal "schema"
      connection.model.should.calledWith "collection", "schema"
