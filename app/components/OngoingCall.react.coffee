# @cjsx React.DOM
React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')
SessionStore = require('../stores/SessionStore')
assign = require("object-assign")

stateFromSessionStore = ->
  return {muted: SessionStore.muted()}

module.exports = React.createClass
  propTypes:
    call: React.PropTypes.object
    room: React.PropTypes.string

  getInitialState: ->
    return assign({inviting: false, inviteName: ''}, stateFromSessionStore())

  componentDidMount: ->
    SessionStore.addChangeListener(@_onChange)

  componentWillUnmount: ->
    SessionStore.removeChangeListener(@_onChange)

  _onChange: ->
    @setState(stateFromSessionStore())

  _onKeyDown: (event)->
    @setState({inviteName: event.target.value})

  _onSubmit: (event)->
    event.preventDefault();
    console.log("submitting")
    text = @state.inviteName.trim()
    if text != ''
      SessionActionCreators.invite(text, call: @props.call, room: @props.room)
    @setState(inviting: false, inviteName: '')

  hangup: (event)->
    event.preventDefault()
    @props.call.hangup()
    SessionActionCreators.callHangup(@props.call)

  mute: (event)->
    event.preventDefault()
    SessionActionCreators.mute()

  unmute: (event)->
    event.preventDefault()
    SessionActionCreators.unmute()

  leaveRoom: (event)->
    SessionActionCreators.leaveRoom(@props.room)
    event.preventDefault()

  invite: (event)->
    event.preventDefault()
    @setState(inviting: true)

  componentDidUpdate: (prevProps, prevState)->
    # if we're now inviting
    if @state.inviting and !prevState.inviting
      @refs.myTextInput.getDOMNode().focus()

  render: ->
    if @state.muted
      muteButton = (<button onClick={@unmute}>Unmute</button>)
    else
      muteButton = (<button onClick={@mute}>Mute</button>)

    if @props.call
      hangupButton = (<button onClick={@hangup}>Hangup</button>)
    else
      hangupButton = (<button onClick={@leaveRoom}>Leave {@props.room}</button>)

    if @state.inviting
      inviteButton = (
        <form onSubmit={@_onSubmit}>
          <input ref="myTextInput" type='text' onKeyDown={@_onKeyDown}/>
        </form>
      )
    else
      inviteButton = (<button onClick={@invite}>Invite</button>)

    return (
      <ul className="ongoing-call">
        <li>
          {muteButton}
        </li>
        <li>
          {inviteButton}
        </li>
        <li>
          {hangupButton}
        </li>
      </ul>
    )

