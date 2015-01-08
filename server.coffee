http = require("http")
express = require("express")
morgan = require('morgan')
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
require('./force_https')(app) if process.env.NODE_ENV == 'production'

allIdentities = {}

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
    res.send identities: Object.keys(allIdentities)

else
  app.get '', (req, res)->
    res.render('not_configured', {title: 'Not Configured'})

require('./on_demand_browserify')(app) if process.env.NODE_ENV == 'development'

# serve static files
app.use express.static(__dirname + "/public")

httpServer.listen port, ->
  console.log "HTTP server started at http://localhost.cine.io:#{port}"

if sslPort = process.env.SSL_PORT
  httpsServer = require('./create_cine_https_server')(app)
  httpsServer.listen sslPort, ->
    console.log "HTTPS server started at https://localhost.cine.io:#{sslPort}"
