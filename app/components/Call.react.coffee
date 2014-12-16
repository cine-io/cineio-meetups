# @cjsx React.DOM

React = require('react')
assign = require('object-assign')
SessionActionCreators = require('../actions/SessionActionCreators')
IdentitiesStore = require('../stores/IdentitiesStore')
ServerAPIBridge = require('../utils/ServerAPIBridge')
Lobby = require('./Lobby.react')



module.exports = React.createClass
  propTypes:
    callback: React.PropTypes.func.isRequired

  getInitialState: ->
    return { callee: '' }

  _onChange: (event)->
    if event.keyCode == ESCAPE_KEY
      @_done()
    else
      @setState({text: event.target.value})

  _call: (callee)->
    console.log "callee: #{callee}"
    if callee
      SessionActionCreators.call(callee)
    @_done()

  _done: ->
    @setState(@getInitialState())
    @props.callback()

  render: ->
    console.log "props:"
    console.dir @props
    console.log "state:"
    console.dir @state
    return (
      <Lobby onSubmit={@_call}
             onCancel={@_done}
             callee={@state.callee}
             help="Select someone to call" />
    )

