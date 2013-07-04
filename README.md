# symfio-contrib-mongoose

> Mongoose plugin.

[![Build Status](http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt13,branch:master/statusIcon?guest=1)](http://teamcity.rithis.com/viewType.html?buildTypeId=bt13&guest=1)
[![Dependency Status](https://gemnasium.com/symfio/symfio-contrib-mongoose.png)](https://gemnasium.com/symfio/symfio-contrib-mongoose)

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

container.inject require "symfio-contrib-mongoose"

container.inject (model) ->
  model "News", "news", (mongoose) ->
    new mongoose.Schema
      title: String
```

## Configuration

### `connectionString`

Default value is `"mongodb://localhost/#{name}"`.

## Services

### `mongoose`

Original `mongoose` module.

### `mongodb`

Original `mongodb` module.

### `connection`

Mongoose connection instance.

### `model`

Model define helper. First argument is container key, second argument is
collection name, last argument is a model factory.
