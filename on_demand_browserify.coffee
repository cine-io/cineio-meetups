path = require('path')
browserify  = require("connect-browserify")
nodejsx     = require("node-cjsx").transform()

module.exports = (app)->
  app.get "/js/bundle.js", browserify(
    entry: path.join(__dirname, "app/app.coffee")
    debug: true
    watch: true
    transforms: ["coffee-reactify"]
    extensions: [".cjsx", ".coffee", ".js", ".json"]
  )
