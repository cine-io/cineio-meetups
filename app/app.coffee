
qs = require('qs')
React = require('react')
Meetups = require('./components/Meetups.react')

CineAPIBridge = require('./utils/CineAPIBridge')
ServerAPIBridge = require('./utils/ServerAPIBridge')
PeerStore = require('./stores/PeerStore')
SessionStore = require('./stores/SessionStore')
MessageStore = require('./stores/MessageStore')
IdentitiesStore = require('./stores/IdentitiesStore')
SessionActionCreators = require('./actions/SessionActionCreators')

CineAPIBridge.init()

ServerAPIBridge.getLobby()

window.onunload = ->
  ServerAPIBridge.unidentify()

window.onpopstate = (event)->
  console.log "popstate:", event.state
  return SessionActionCreators.joinRoom(event.state.room) if event.state and event.state.room
  SessionActionCreators.leaveRoom(SessionStore.getCurrentRoom()) if SessionStore.getCurrentRoom()

queryArgs = if window then qs.parse(window.location.search[1..]) else {}
if queryArgs.room
  SessionActionCreators.joinRoom(queryArgs.room)

React.render(
  <Meetups />,
  document.getElementById('container')
)
