https = require("https")
http = require("http")
fs = require("fs")
path = require('path')
express = require("express")
morgan = require('morgan')
_ = require('lodash')
CineIO = require('cine-io')
port = process.env.PORT or 9090

# CINE IO API KEYS

keys = require('./fetch_api_keys_from_environment')()
publicKey = keys.publicKey
secretKey = keys.secretKey
cineIoClient = CineIO.init({secretKey: secretKey})

app = express()
app.use morgan("dev")
httpServer = http.createServer(app)

app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

allIdentities = {}

if process.env.NODE_ENV == 'production'
  forceHttps = (req, res, next) ->
    isHttps = req.headers["x-forwarded-proto"] == 'https'
    return next() if isHttps
    host = req.headers.host
    res.redirect("https://" + host + req.url)
  app.use forceHttps

if secretKey
  app.get '', (req, res)->
    res.render('index', publicKey: publicKey)

  app.get '/identity/:identity', (req, res)->
    identity = req.param('identity')
    allIdentities[identity] = true
    res.send cineIoClient.peer.generateIdentitySignature(identity)

  app.get '/unidentify/:identity', (req, res)->
    delete allIdentities[req.param('identity')]
    res.status(200).end()

  app.get '/lobby', (req, res)->
    res.send identities: _.keys(allIdentities)

else
  app.get '', (req, res)->
    res.render('not_configured', {title: 'Not Configured'})

if process.env.NODE_ENV == 'development'
  browserify  = require("connect-browserify")
  nodejsx     = require("node-cjsx").transform()
  app.get "/js/bundle.js", browserify(
    entry: path.join(__dirname, "app/app.coffee")
    debug: true
    watch: true
    transforms: ["coffee-reactify"]
    extensions: [".cjsx", ".coffee", ".js", ".json"]
  )

# serve static files
app.use express.static(__dirname + "/public")

httpServer.listen port, ->
  console.log "HTTP server started at http://localhost.cine.io:#{port}"

if process.env.SSL_PORT
  httpsServer = require('./create_cine_https_server')(app)
  httpsServer.listen process.env.SSL_PORT, ->
    console.log "HTTPS server started at https://localhost.cine.io:#{sslPort}"
