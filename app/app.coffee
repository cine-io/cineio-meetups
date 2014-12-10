React = require('react')
Example = require('./components/Example.react')

CineAPIBridge = require('./utils/CineAPIBridge')
PeerStore = require('./stores/PeerStore')
SessionStore = require('./stores/SessionStore')

CineAPIBridge.init()

React.render(
  <Example />,
  document.getElementById('container')
)
