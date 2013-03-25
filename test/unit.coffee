mongoose = require "mongoose"
symfio = require "symfio"
plugin = require "../lib/mongoose"
suite = require "symfio-suite"


describe "contrib-mongoose plugin", ->
  wrapper = suite.sandbox symfio, ->
    @sandbox.stub mongoose.Connection.prototype, "open"
    @open = mongoose.Connection.prototype.open

  it "should generate connection string using name value", wrapper ->
    plugin @container, ->

    @expect(@open).to.have.been.calledOnce
    @expect(@open.firstCall.args[0]).to.equal "mongodb://localhost/symfio"

  it "should use MONGOHQ_URL as connection string", wrapper ->
    mongohqUrl = process.env.MONGOHQ_URL
    process.env.MONGOHQ_URL = "mongodb://127.0.0.1/abra-kadabra"

    plugin @container, ->

    @expect(@open).to.have.been.calledOnce
    @expect(@open.firstCall.args[0]).to.equal process.env.MONGOHQ_URL

    process.env.MONGOHQ_URL = mongohqUrl
