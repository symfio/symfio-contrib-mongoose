suite = require "symfio-suite"


describe "contrib-mongoose()", ->
  it = suite.plugin (container) ->
    container.inject ["suite/container"], require ".."

    container.set "connection", (sandbox) ->
      connection =
        open: sandbox.stub()
        model: sandbox.stub()
      connection.open.yields()
      connection

    container.set "mongoose", (sandbox, connection) ->
      mongoose = createConnection: sandbox.stub()
      mongoose.mongo = "mongodb"
      mongoose.createConnection.returns connection
      mongoose

  describe "container.require mongoose", ->
    it "should define", (required) ->
      required("mongoose").should.equal "mongoose"

  describe "container.unless connectionString", ->
    it "should generate connection string using name value",
      (unlessed) ->
        factory = unlessed "connectionString"
        factory().should.eventually.equal "mongodb://localhost/test"

  describe "container.set mongodb", ->
    it "should define", (setted) ->
      factory = setted "mongodb"
      factory().should.eventually.equal "mongodb"

  describe "container.set connection", ->
    it "should connect", (setted, connection) ->
      factory = setted "connection"
      factory.dependencies.connectionString = "connectionString"
      factory().then ->
        connection.open.should.be.calledOnce
        connection.open.should.be.calledWith "connectionString"

  describe "container.set model", ->
    it "should define model",
    ["setted", "suite/container", "connection"],
    (setted, container, connection) ->
      factory = setted "model"
      factory.dependencies.container = container
      factory().then (model) ->
        model "Model", "collection", "factory"
        modelFactory = setted "Model"
        modelFactory()
      .then ->
        container.inject.promise.then.yield "schema"
        container.inject.should.be.calledWith "factory"
        modelSchemaFactory = setted "ModelSchema"
        modelSchemaFactory().should.eventually.equal "schema"
        connection.model.should.calledWith "collection", "schema"
