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
    @setState({text: event.target.value})

  _onSubmit: (event)->
    event.preventDefault();
    text = @state.text.trim()
    if text == ''
      @refs.myTextInput.getDOMNode().focus()
      @refs.myTextInput.getDOMNode().style.borderColor = "red"
    else
      SessionActionCreators.identify(text)
      @_done()

  _done: ->
    @props.callback()

  componentDidMount: ->
    @refs.myTextInput.getDOMNode().focus()

  render: ->
    return (
      <div className="identify">
        <form onSubmit={@_onSubmit}>
          <input ref="myTextInput" placeholder="Your name (required)" type='text' onKeyDown={@_onChange}/>
          <button type="submit" onClick={@_onSubmit}>OK</button>
        </form>
      </div>
    )

