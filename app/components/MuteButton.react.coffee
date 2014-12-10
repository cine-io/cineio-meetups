# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')
assign = require("object-assign")
SessionStore = require('../stores/SessionStore')

stateFromSessionStore = ->
  return {audioMuted: SessionStore.audioMuted(), videoMuted: SessionStore.videoMuted()}

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

  startCameraAndMicrophone: (event)->
    event.preventDefault()
    SessionActionCreators.startCameraAndMicrophone()

  componentDidMount: ->
    SessionStore.addChangeListener(@_onChange)

  componentWillUnmount: ->
    SessionStore.removeChangeListener(@_onChange)

  _onChange: ->
    @setState(stateFromSessionStore())

  render: ->
    if @state.audioMuted && @state.videoMuted
      return (
        <ul className="mute">
          <li>
            <button onClick={@startCameraAndMicrophone}>Turn on Mic and Camera</button>
          </li>
        </ul>
      )
    else
      if @state.audioMuted
        audioButton = (<button onClick={@unmuteAudio}>Unmute</button>)
      else
        audioButton = (<button onClick={@muteAudio}>Mute</button>)

      if @state.videoMuted
        videoButton = (<button onClick={@unmuteVideo}>On Camera</button>)
      else
        videoButton = (<button onClick={@muteVideo}>Off Camera</button>)

    return (
      <ul className="mute">
        <li>
          {audioButton}
        </li>
        <li>
          {videoButton}
        </li>
      </ul>
    )
