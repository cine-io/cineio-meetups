React = require('react')
Example = require('./components/Example.react')

CineAPIBridge = require('./utils/CineAPIBridge')
ServerAPIBridge = require('./utils/ServerAPIBridge')
PeerStore = require('./stores/PeerStore')
SessionStore = require('./stores/SessionStore')
IdentitiesStore = require('./stores/IdentitiesStore')

CineAPIBridge.init()

ServerAPIBridge.getLobby()

window.onunload = ->
  ServerAPIBridge.unidentify()

React.render(
  <Example />,
  document.getElementById('container')
)
