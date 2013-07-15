# symfio-contrib-mongoose

> Mongoose plugin for Symfio.

[![Build Status](https://travis-ci.org/symfio/symfio-contrib-mongoose.png?branch=master)](https://travis-ci.org/symfio/symfio-contrib-mongoose)
[![Coverage Status](https://coveralls.io/repos/symfio/symfio-contrib-mongoose/badge.png?branch=master)](https://coveralls.io/r/symfio/symfio-contrib-mongoose?branch=master)
[![Dependency Status](https://gemnasium.com/symfio/symfio-contrib-mongoose.png)](https://gemnasium.com/symfio/symfio-contrib-mongoose)
[![NPM version](https://badge.fury.io/js/symfio-contrib-mongoose.png)](http://badge.fury.io/js/symfio-contrib-mongoose)

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
