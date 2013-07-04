chai = require "chai"
w = require "when"


describe "contrib-mongoose example", ->
  chai.use require "chai-as-promised"
  chai.use require "chai-http"
  chai.should()

  container = require "../example"
  container.set "env", "test"

  before (callback) ->
    container.promise.should.notify callback

  describe "GET /", ->
    it "should respond with apple", (callback) ->
      container.get("app").then (app) ->
        deferred = w.defer()
        chai.request(app).get("/").res deferred.resolve
        deferred.promise
      .then (res) ->
        res.should.have.status 200
        res.body.should.have.length 1
        res.body[0].name.should.equal "Apple"
      .should.notify callback
