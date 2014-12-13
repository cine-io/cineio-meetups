# @cjsx React.DOM
React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')
MediaControls = require('./MediaControls.react')

ESCAPE_KEY = 27

module.exports = React.createClass
  propTypes:
    call: React.PropTypes.object
    room: React.PropTypes.string

  getInitialState: ->
    return {inviting: false, inviteName: ''}

  _onKeyDown: (event)->
    if event.keyCode == ESCAPE_KEY
      @_resetInvite()
    else
      @setState({inviteName: event.target.value})

  _onSubmit: (event)->
    event.preventDefault();
    console.log("submitting")
    text = @state.inviteName.trim()
    if text != ''
      SessionActionCreators.invite(text, call: @props.call, room: @props.room)
    @_resetInvite()

  _resetInvite: ->
    @setState(inviting: false, inviteName: '')

  hangup: (event)->
    event.preventDefault()
    @props.call.hangup()
    SessionActionCreators.callHangup(@props.call)

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

    if @props.call
      hangupButton = (<button onClick={@hangup}><i className="fa fa-2x fa-phone"></i></button>)
    else
      hangupButton = (<button onClick={@leaveRoom}><i className="fa fa-2x fa-sign-out"></i></button>)

    if @state.inviting
      inviteButton = (
        <form onSubmit={@_onSubmit}>
          <input ref="myTextInput" type='text' onKeyDown={@_onKeyDown}/>
        </form>
      )
    else
      inviteButton = (<button onClick={@invite}><i className="fa fa-2x fa-user"></i></button>)

    return (
      <ul className="ongoing-call">
        <li>
          <MediaControls />
        </li>
        <li>
          {inviteButton}
        </li>
        <li>
          {hangupButton}
        </li>
      </ul>
    )

