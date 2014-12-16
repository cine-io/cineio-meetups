# @cjsx React.DOM

React = require('react')
assign = require('object-assign')
SessionActionCreators = require('../actions/SessionActionCreators')
IdentitiesStore = require('../stores/IdentitiesStore')
SessionStore = require('../stores/SessionStore')
ServerAPIBridge = require('../utils/ServerAPIBridge')

ESCAPE_KEY = 27

stateFromSessionStore = ->
  identities = [{value: '', name: 'Select someone to call'}, {value: 'Cancel', name: 'Cancel'}]
  allIdentities = IdentitiesStore.getIdentities()
  allIdentities.splice allIdentities.indexOf(SessionStore.getIdentity()), 1
  identities = identities.concat allIdentities
  return {identities: identities}

module.exports = React.createClass
  propTypes:
    callback: React.PropTypes.func.isRequired

  getInitialState: ->
    return assign {text: ''}, stateFromSessionStore()

  _onChange: (event)->
    if event.keyCode == ESCAPE_KEY
      @_done()
    else
      @setState({text: event.target.value})

  _onSubmit: (event)->
    event.preventDefault()
    text = event.currentTarget.value
    if text != '' && text != 'Cancel'
      SessionActionCreators.call(text)
    @_done()

  componentDidMount: ->
    IdentitiesStore.addChangeListener(@_onChange)
    ServerAPIBridge.getLobby()

  componentWillUnmount: ->
    IdentitiesStore.removeChangeListener(@_onChange)

  _onChange: ->
    @setState(stateFromSessionStore())

  _done: ->
    @setState(@getInitialState())
    @props.callback()

  render: ->
    return (

      options = for identity in @state.identities
        name = identity.name || identity
        value = if identity.value || identity.value == '' then identity.value else identity
        (<option key={name} value={value}>{name}</option>)

      <div className="call">
        <form onSubmit={@_onSubmit}>
          <select ref="myTextInput" onChange={@_onSubmit} onKeyDown={@_onChange} value={@state.text}>
           {options}
         </select>
       </form>
      </div>
    )

