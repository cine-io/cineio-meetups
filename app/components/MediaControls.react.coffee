# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')
assign = require("object-assign")
SessionStore = require('../stores/SessionStore')
PeerStore = require('../stores/PeerStore')

stateFromSessionStore = ->
  return {screenShareStarted: PeerStore.getScreenShareStream(), cameraAndMicStarted: PeerStore.getCameraStream(), audioMuted: SessionStore.audioMuted(), videoMuted: SessionStore.videoMuted()}

module.exports = React.createClass

  getInitialState: ->
    return assign({}, stateFromSessionStore())

  muteAudio: (event)->
    event.preventDefault()
    SessionActionCreators.muteAudio()

  unmuteAudio: (event)->
    event.preventDefault()
    SessionActionCreators.unmuteAudio()

  muteVideo: (event)->
    event.preventDefault()
    SessionActionCreators.muteVideo()

  unmuteVideo: (event)->
    event.preventDefault()
    SessionActionCreators.unmuteVideo()

  stopScreenShare: (event)->
    event.preventDefault()
    SessionActionCreators.stopScreenShare()

  startScreenShare: (event)->
    event.preventDefault()
    SessionActionCreators.startScreenShare()

  startCameraAndMicrophone: (event)->
    event.preventDefault()
    SessionActionCreators.startCameraAndMicrophone()

  componentDidMount: ->
    SessionStore.addChangeListener(@_onChange)
    PeerStore.addChangeListener(@_onChange)

  componentWillUnmount: ->
    SessionStore.removeChangeListener(@_onChange)
    PeerStore.removeChangeListener(@_onChange)

  _onChange: ->
    @setState(stateFromSessionStore()) if @isMounted()

  render: ->
    if @state.screenShareStarted
      screenShareButton = (<button onClick={@stopScreenShare}><i className="fa fa-2x fa-desktop"></i></button>)
    else
      screenShareButton = (<button onClick={@startScreenShare}><i className="fa fa-2x fa-desktop"></i></button>)

    if !@state.cameraAndMicStarted
      return (
        <ul className="mute">
          <li>
            <button className="camera-and-microphone" onClick={@startCameraAndMicrophone}>
              <i className="fa fa-2x fa-video-camera"></i>
              &nbsp;
              <i className="fa fa-plus"></i>
              &nbsp
              <i className="fa fa-2x fa-microphone"></i>
            </button>
          </li>
          <li>
            {screenShareButton}
          </li>
        </ul>
      )
    else
      if @state.audioMuted
        audioButton = (<button onClick={@unmuteAudio}><i className="fa fa-2x fa-microphone"></i></button>)
      else
        audioButton = (<button onClick={@muteAudio}><i className="fa fa-2x fa-microphone"></i></button>)

      if @state.videoMuted
        videoButton = (<button onClick={@unmuteVideo}><i className="fa fa-2x fa-video-camera"></i></button>)
      else
        videoButton = (<button onClick={@muteVideo}><i className="fa fa-2x fa-video-camera"></i></button>)

    return (
      <ul className="mute">
        <li>
          {videoButton}
        </li>
        <li>
          {audioButton}
        </li>
        <li>
          {screenShareButton}
        </li>
      </ul>
    )
