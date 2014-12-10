# @cjsx React.DOM
React = require('react')
assign = require("object-assign")
JoinRoom = require('./JoinRoom.react')
SessionStore = require('../stores/SessionStore')
SessionActionCreators = require('../actions/SessionActionCreators')

stateFromSessionStore = ->
  return {currentRoom: SessionStore.getCurrentRoom(), muted: SessionStore.muted()}

module.exports = React.createClass

  getInitialState: ->
    return assign({joiningRoom: false, callingSomebody: false}, stateFromSessionStore())

  joinRoom: (event)->
    event.preventDefault()
    @setState(joiningRoom: true)

  exitJoinRoom: ->
    @setState(joiningRoom: false)

  mute: (event)->
    event.preventDefault()
    SessionActionCreators.mute()

  unmute: (event)->
    event.preventDefault()
    SessionActionCreators.unmute()

  componentDidMount: ->
    SessionStore.addChangeListener(this._onChange)

  componentWillUnmount: ->
    SessionStore.removeChangeListener(this._onChange)

  _onChange: ->
    @setState(stateFromSessionStore())

  leaveRoom: (event)->
    SessionActionCreators.leaveRoom(@state.currentRoom)
    event.preventDefault()

  render: ->
    if @state.joiningRoom
      view = (<JoinRoom callback={@exitJoinRoom}/>)
    else
      if @state.muted
        muteButton = (<button onClick={@unmute}>Unmute</button>)
      else
        muteButton = (<button onClick={@mute}>Mute</button>)
      if @state.currentRoom
        roomButton = (<button onClick={@leaveRoom}>Leave {@state.currentRoom}</button>)
      else
        roomButton = (<button onClick={@joinRoom}>Join Room</button>)
      view = (
        <ul>
          <li>
            {muteButton}
          </li>
          <li>
            <button>Call Somebody</button>
          </li>
          <li>
            {roomButton}
          </li>
        </ul>
      )
    return (
      <div className="controls">
        {view}
      </div>
    )

