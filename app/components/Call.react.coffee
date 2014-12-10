# @cjsx React.DOM

React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')

module.exports = React.createClass
  propTypes:
    callback: React.PropTypes.func.isRequired

  getInitialState: ->
    return {text: ''}

  _onChange: (event)->
    @setState({text: event.target.value})

  _onSubmit: (event)->
    event.preventDefault();
    console.log("submitting")
    text = @state.text.trim()
    if text != ''
      SessionActionCreators.call(text)
    @setState(@getInitialState())
    @props.callback()

  componentDidMount: ->
    @refs.myTextInput.getDOMNode().focus()

  render: ->
    return (
      <div className="controls">
        <form onSubmit={@_onSubmit}>
          <input ref="myTextInput" type='text' onKeyDown={@_onChange}/>
        </form>
      </div>
    )

