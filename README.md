# symfio-contrib-mongoose

> Connect to MongoDB database using mongoose module.

[![Build Status](http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt13,branch:master/statusIcon?guest=1)](http://teamcity.rithis.com/viewType.html?buildTypeId=bt13&guest=1)
[![Dependency Status](https://gemnasium.com/symfio/symfio-contrib-mongoose.png)](https://gemnasium.com/symfio/symfio-contrib-mongoose)

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

loader = container.get "loader"

loader.use require "symfio-contrib-mongoose"

loader.use (container, callback) ->
  connection = container.get "connection"
  mongoose = container.get "mongoose"

  NewsSchema = new mongoose.Schema
    title: String

  News = connection.model "news", NewsSchema

  callback()

loader.load()
```

## Provides

* __connection__ — Mongoose connection instance.
* __mongoose__ — `mongoose` module.
* __mongodb__ — `mongodb` module.

## Can be configured

* __connection string__ - Default value received from `process.env.MONGOHQ_URL`.
  If `process.env.MONGOHQ_URL` is undefined then default value is
  `"mongodb://localhost/#{name}"`.
