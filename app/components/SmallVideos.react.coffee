# @cjsx React.DOM

React = require('react')
Video = require('./Video.react')
PeerStore = require('../stores/PeerStore')
PeerActionCreators = require('../actions/PeerActionCreators')

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

  onClick: (video, event)->
    PeerActionCreators.selectVideo(video)

  render: ->
    videos = for video in @state.videos
      (<Video key={video.src} video={video} onClick={@onClick.bind(this, video)} />)
    return (
      <div className="small-videos">
        {videos}
      </div>
    )

  _onChange: ->
    @setState(getStateFromStores())
