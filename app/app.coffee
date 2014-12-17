React = require('react')
Meetups = require('./components/Meetups.react')

CineAPIBridge = require('./utils/CineAPIBridge')
ServerAPIBridge = require('./utils/ServerAPIBridge')
PeerStore = require('./stores/PeerStore')
SessionStore = require('./stores/SessionStore')
MessageStore = require('./stores/MessageStore')
IdentitiesStore = require('./stores/IdentitiesStore')

CineAPIBridge.init()

ServerAPIBridge.getLobby()

window.onunload = ->
  ServerAPIBridge.unidentify()

React.render(
  <Meetups />,
  document.getElementById('container')
)
