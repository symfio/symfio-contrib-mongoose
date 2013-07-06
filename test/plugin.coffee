suite = require "symfio-suite"


describe "contrib-mongoose()", ->
  it = suite.plugin [
    require ".."
  ]

  describe "container.unless connectionString", ->
    it "should generate connection string using name value",
      (connectionString) ->
        connectionString.should.equal "mongodb://localhost/test"

  describe "container.set mongoose", ->
    it "should define", (container) ->
      container.has("mongoose").should.be.true

  describe "container.set mongodb", ->
    it "should define", (container) ->
      container.has("mongodb").should.be.true

  describe "container.set connection", ->
    it "should connect", (container) ->
      container.set "connectionStub", (sandbox) ->
        connectionStub = open: sandbox.stub()
        connectionStub.open.yields()
        connectionStub

      container.set "mongoose", (sandbox, connectionStub) ->
        mongoose = createConnection: sandbox.stub()
        mongoose.createConnection.returns connectionStub
        mongoose

      container.inject (connection, connectionString) ->
        connection.open.should.be.calledOnce
        connection.open.should.be.calledWith connectionString

  describe "container.set model", ->
    it "should define model", (model, container) ->
      model "Model", "collection", (mongoose) ->
        new mongoose.Schema
          abcde: String

      container.inject (Model) ->
        Model.schema.tree.should.have.property "abcde"
