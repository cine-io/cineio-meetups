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
    SessionActionCreators.identify(this.state.text.trim())
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

