# @cjsx React.DOM

React = require('react')
PeerStore = require('../stores/PeerStore')
Video = require('./Video.react')

getStateFromStores = ->
  result =
    video: PeerStore.getMainVideo()
  return result

module.exports = React.createClass

  getInitialState: ->
    return getStateFromStores()

  componentDidMount: ->
    PeerStore.addChangeListener(this._onChange)

  componentWillUnmount: ->
    PeerStore.removeChangeListener(this._onChange)

  render: ->
    video = if this.state.video then (<Video video={this.state.video} />) else ''
    return (
      <div id="main-video">
        {video}
      </div>
    )

  _onChange: ->
    @setState(getStateFromStores())
