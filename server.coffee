https = require("https")
http = require("http")
fs = require("fs")
path = require('path')
express = require("express")
morgan = require('morgan')
_ = require('lodash')
port = process.env.PORT or 9090

# CINE IO API KEYS
generateSecureIdentity = require('./generate_secure_identity')
keys = require('./fetch_api_keys_from_environment')()
publicKey = keys.publicKey
secretKey = keys.secretKey

app = express()
app.use morgan("dev")
httpServer = http.createServer(app)

if process.env.SSL_PORT
  sslPort = process.env.SSL_PORT or 9443
  sslCertsPath = process.env.SSL_CERTS_PATH or __dirname
  sslCertFile = "localhost-cine-io.crt"
  sslKeyFile = "localhost-cine-io.key"
  sslIntermediateCertFiles = [ "COMODORSADomainValidationSecureServerCA.crt", "COMODORSAAddTrustCA.crt", "AddTrustExternalCARoot.crt" ]
  sslKey = fs.readFileSync("#{sslCertsPath}/#{sslKeyFile}")
  sslCert = fs.readFileSync("#{sslCertsPath}/#{sslCertFile}")
  sslCA = (fs.readFileSync "#{sslCertsPath}/#{file}" for file in sslIntermediateCertFiles)
  options =
    ca: sslCA
    cert: sslCert
    key: sslKey
    requestCert: true
    rejectUnauthorized: false
    agent: false

  httpsServer = https.createServer(options, app)

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
    res.send generateSecureIdentity(identity, secretKey)

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
  httpsServer.listen sslPort, ->
    console.log "HTTPS server started at https://localhost.cine.io:#{sslPort}"
