suite = require "symfio-suite"


describe "contrib-mongoose example", ->
  it = suite.example require "../example"

  describe "GET /", ->
    it "should respond with apple", (request) ->
      request.get("/").then (res) ->
        res.should.have.status 200
        res.body.should.have.length 1
        res.body[0].name.should.equal "Apple"
