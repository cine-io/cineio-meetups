# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')

ESCAPE_KEY = 27

module.exports = React.createClass
  propTypes:
    callback: React.PropTypes.func.isRequired

  getInitialState: ->
    return {text: ''}

  _onChange: (event)->
    if event.keyCode == ESCAPE_KEY
      @_done()
    else
      @setState({text: event.target.value})

  _onSubmit: (event)->
    event.preventDefault()
    console.log("submitting")
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
        <form onSubmit={this._onSubmit}>
          <input ref="myTextInput" placeholder="Room name" type='text' onKeyDown={this._onChange}/>
          <button type="submit" className="ok" onClick={@_onSubmit}>OK</button>
          <button type="cancel" className="cancel" onClick={@_onCancel}>Cancel</button>
        </form>
      </div>
    )

