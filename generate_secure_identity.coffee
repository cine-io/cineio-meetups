crypto = require('crypto')

generateSignature = (identity, timestamp, secretKey)->
  shasum = crypto.createHash('sha1')

  signatureToSha = "identity=#{identity}&timestamp=#{timestamp}#{secretKey}"
  shasum.update(signatureToSha)
  shasum.digest('hex')

generateSecureIdentity = (identity, secretKey)->
  timestamp = Math.floor(Date.now() / 1000)
  signature = generateSignature(identity, timestamp, secretKey)
  response =
    timestamp:  timestamp
    signature: signature
    identity: identity
  return response

module.exports = generateSecureIdentity
