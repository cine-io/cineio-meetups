# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')
assign = require("object-assign")
SessionStore = require('../stores/SessionStore')
PeerStore = require('../stores/PeerStore')
FAToggleButton = require('./FAToggleButton.react')

stateFromSessionStore = ->
  return {screenShareStarted: PeerStore.getScreenShareStream(), cameraAndMicStarted: PeerStore.getCameraStream(), audioMuted: SessionStore.audioMuted(), videoMuted: SessionStore.videoMuted()}

module.exports = React.createClass

  hoverIcon: (event)->
    event.preventDefault()
    button = event.target
    console.log button

  toggleIconBan: (event)->
    $button = $(event.target)


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
    screenShareButtonOnClick = if @state.screenShareStarted then @stopScreenShare else @startScreenShare
    console.log "screen share started?", @state.screenShareStarted
    screenShareButton = (
      <FAToggleButton
        onClassName="cine-screenshare"
        offClassName="cine-screenshare-slash"
        buttonName="Screen Sharing"
        isOn={if @state.screenShareStarted then true else false}
        onClick={screenShareButtonOnClick}/>
    )

    if !@state.cameraAndMicStarted
      return (
        <ul className="mute">
          <li>
            <button className="camera-and-microphone" onClick={@startCameraAndMicrophone}>
              <i className="fa fa-3x cine-video-camera"></i>
              &nbsp;
              <i className="fa fa-plus"></i>
              &nbsp;
              <i className="fa fa-3x cine-microphone"></i>
            </button>
          </li>
          <li>
            {screenShareButton}
          </li>
        </ul>
      )
    else
      audioButtonOnClick = if @state.audioMuted then @unmuteAudio else @muteAudio
      audioButton = (
        <FAToggleButton
          onClassName="cine-microphone"
          offClassName="cine-microphone-slash"
          buttonName="Microphone"
          isOn={!@state.audioMuted}
          onClick={audioButtonOnClick}/>
      )
      videoButtonOnClick = if @state.videoMuted then @unmuteVideo else @muteVideo
      videoButton = (
        <FAToggleButton
          onClassName="cine-video-camera"
          offClassName="cine-video-camera-slash"
          buttonName="Video Camera"
          isOn={!@state.videoMuted}
          onClick={videoButtonOnClick}/>
      )

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
