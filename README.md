# symfio-contrib-mongoose

> Connect to MongoDB database using mongoose module.

[![Build Status](http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt13,branch:master/statusIcon?guest=1)](http://teamcity.rithis.com/viewType.html?buildTypeId=bt13&guest=1)
[![Dependency Status](https://gemnasium.com/symfio/symfio-contrib-mongoose.png)](https://gemnasium.com/symfio/symfio-contrib-mongoose)

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

container.use require "symfio-contrib-mongoose"

container.use (model) ->
  model "News", "news", (mongoose) ->
    NewsSchema = new mongoose.Schema
      title: String

container.load()
```

## Provides

* __connection__ — Mongoose connection instance.
* __mongoose__ — `mongoose` module.
* __mongodb__ — `mongodb` module.
* __model__ — Model define helper. First argument is container key, second
  argument is collection name, last argument is factory.

## Can be configured

* __connection string__ - Default value is `"mongodb://localhost/#{name}"`.
