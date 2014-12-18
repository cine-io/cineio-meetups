# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')

ESCAPE_KEY = 27

module.exports = React.createClass
  propTypes:
    callback: React.PropTypes.func.isRequired

  getInitialState: ->
    return {text: ''}

  _onKeyDown: (event)->
    if event.keyCode == ESCAPE_KEY
      @_done()

  _onChange: (event)->
    @setState({text: event.target.value})

  _onSubmit: (event)->
    event.preventDefault()
    text = @state.text.trim()
    if text != ''
      SessionActionCreators.joinRoom(text)
    @_done()

  _onCancel: (event)->
    event.preventDefault()
    @_done()

  _done: ->
    @setState(@getInitialState())
    @props.callback()

  componentDidMount: ->
    this.refs.myTextInput.getDOMNode().focus()

  render: ->
    return (
      <div className="join-room">
        <form onSubmit={@_onSubmit}>
          <input ref="myTextInput" placeholder="Room name" type='text' value={@state.text} onChange={@_onChange} onKeyDown={@_onKeyDown}/>
          <button type="submit" className="ok" onClick={@_onSubmit}>OK</button>
          <button type="cancel" className="cancel" onClick={@_onCancel}>Cancel</button>
        </form>
      </div>
    )

