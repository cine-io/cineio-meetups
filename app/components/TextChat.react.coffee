# @cjsx React.DOM

React = require('react')
Message = require('./Message.react')
assign = require('object-assign')
MessageStore = require('../stores/MessageStore')
SessionStore = require('../stores/SessionStore')
MessageActionCreators = require('../actions/MessageActionCreators')
PeerActionCreators = require('../actions/PeerActionCreators')

ENTER_KEY_CODE = 13

getStateFromStores = ->
  result =
    messages: MessageStore.getMessages()
    identity: SessionStore.getIdentity()
  return result

module.exports = React.createClass

  getInitialState: ->
    return assign {text: ''}, getStateFromStores()

  componentDidMount: ->
    MessageStore.addChangeListener(@_onChange)
    SessionStore.addChangeListener(@_onChange)

  componentWillUnmount: ->
    MessageStore.removeChangeListener(@_onChange)
    SessionStore.removeChangeListener(@_onChange)

  _onChange: (event)->
    @setState(getStateFromStores())

  _onTextChange: (event)->
    @setState(text: event.target.value)

  _onKeyDown: (event)->
    @_onSubmit(event) if event.keyCode == ENTER_KEY_CODE

  _onSubmit: (event)->
    event.preventDefault()
    text = @state.text.trim()
    if text != ''
      message =
        identity: @state.identity
        text: text
        type: 'message'
        timestamp: (new Date).getTime()
      MessageActionCreators.createMessage(message)
    @setState(text: '')
    messagesEl = @refs.messages.getDOMNode()
    messagesEl.scrollTop = messagesEl.scrollHeight;

  render: ->
    messages = for message in @state.messages
      key = "#{message.text}:#{message.timestamp}"
      (
        <li key={key}>
          <Message message={message} />
        </li>
      )
    return (
      <div className="chat-wrapper">
        <h4>Group Chat</h4>
        <div ref="messages" className="messages">
          <ul>
            {messages}
          </ul>
        </div>
        <div className="new-message">
          <form onSubmit={@_onSubmit}>
            <textarea placeholder="Type a message ..." onKeyDown={@_onKeyDown} onChange={@_onTextChange} value={@state.text}/>
          </form>
        </div>
      </div>
    )

  _onChange: ->
    @setState(getStateFromStores())
