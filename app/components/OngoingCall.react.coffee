# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')
MediaControls = require('./MediaControls.react')
Lobby = require('./Lobby.react')

ESCAPE_KEY = 27

module.exports = React.createClass
  propTypes:
    call: React.PropTypes.object
    room: React.PropTypes.string

  getInitialState: ->
    return {inviting: false, inviteName: ''}

  _sendInvite: (inviteName)->
    if inviteName
      SessionActionCreators.invite(inviteName, call: @props.call, room: @props.room)
    @_resetInvite()

  _resetInvite: ->
    @setState(@getInitialState())

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

  render: ->
    if @state.inviting
      return (
        <Lobby onSubmit={@_sendInvite}
               onCancel={@_resetInvite}
               callee={@state.inviteName}
               help="Select someone to invite" />
      )
    else
      if @props.call
        hangupButton = (<button className="cancel" title="Hang up" onClick={@hangup}><i className="fa fa-3x cine-hangup"></i></button>)
      else
        hangupButton = (<button className="cancel" title="Leave room" onClick={@leaveRoom}><i className="fa fa-3x fa-sign-out"></i></button>)

      inviteButton = (<button title="Invite user" onClick={@invite}><i className="fa fa-3x fa-user"></i></button>)

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

