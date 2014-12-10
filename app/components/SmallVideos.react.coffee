# @cjsx React.DOM

React = require('react')
Video = require('./Video.react')
PeerStore = require('../stores/PeerStore')

getStateFromStores = ->
  result =
    videos: PeerStore.getOtherVideos()
  return result

module.exports = React.createClass

  getInitialState: ->
    return getStateFromStores()

  componentDidMount: ->
    PeerStore.addChangeListener(@_onChange)

  componentWillUnmount: ->
    PeerStore.removeChangeListener(@_onChange)

  render: ->
    videos = for video in @state.videos
      (<Video key={video.src} video={video} />)
    return (
      <div className="small-videos">
        {videos}
      </div>
    )

  _onChange: ->
    @setState(getStateFromStores())
