request = require('superagent')

processIdentity = (error, res)->
  # TODO: handle errors
  return if error
  SessionActionCreators.secureIdentify(res.body)

processLobby = (error, res)->
  # TODO: handle errors
  return if error
  AppActionCreators.processLobby(res.body.identities)

ServerAPIBridge =

  identify: (name)->
    request.get("/identity/#{name}").end(processIdentity)

  unidentify: ->
    identity = SessionStore.getIdentity()
    return unless identity
    request = new XMLHttpRequest()
    request.open('GET', "/unidentify/#{identity}", false) #false for synchronous
    request.send(null)

  getLobby: ->
    console.log("GETTING LOBBY")
    request.get("/lobby").end(processLobby)

module.exports = ServerAPIBridge

SessionActionCreators = require('../actions/SessionActionCreators')
SessionStore = require('../stores/SessionStore')
AppActionCreators = require('../actions/AppActionCreators')
