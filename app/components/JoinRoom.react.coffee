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
    event.preventDefault();
    console.log("submitting")
    text = @state.text.trim()
    if text != ''
      SessionActionCreators.joinRoom(text)
    @_done()

  _done: ->
    @setState(@getInitialState())
    @props.callback()

  componentDidMount: ->
    this.refs.myTextInput.getDOMNode().focus()

  render: ->
    return (
      <div className="controls">
        <form onSubmit={this._onSubmit}>
          <input ref="myTextInput" type='text' onKeyDown={this._onChange}/>
        </form>
      </div>
    )

