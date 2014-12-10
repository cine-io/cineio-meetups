crypto = require('crypto')

module.exports = (identity, secretKey)->
  shasum = crypto.createHash('sha1')
  timestamp = Math.floor(Date.now() / 1000)

  signatureToSha = "identity=#{identity}&timestamp=#{timestamp}#{secretKey}"
  shasum.update(signatureToSha)
  signature = shasum.digest('hex')
  response =
    timestamp:  timestamp
    signature: signature
    identity: identity
  return response
