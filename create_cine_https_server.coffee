module.exports = (app)->
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
