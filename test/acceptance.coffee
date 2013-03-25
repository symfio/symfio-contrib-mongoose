suite = require "symfio-suite"


describe "contrib-mongoose example", ->
  wrapper = suite.http require "../example"

  describe "GET /", ->
    it "should respond with apple", wrapper (callback) ->
      test = @http.get "/"

      test.res (res) =>
        @expect(res).to.have.status 200
        @expect(res.body.name).to.equal "Apple"

        callback()
