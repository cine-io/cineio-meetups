request = require('superagent')

processIdentity = (error, res)->
  # TODO: handle errors
  return if error
  SessionActionCreators.secureIdentify(res.body)

ServerAPIBridge =

  identify: (name)->
    request.get("/identity/#{name}").end(processIdentity)

module.exports = ServerAPIBridge

SessionActionCreators = require('../actions/SessionActionCreators')
