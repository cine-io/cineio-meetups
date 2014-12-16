# @cjsx React.DOM

React = require('react')
IdentitiesStore = require('../stores/IdentitiesStore')
SessionStore = require('../stores/SessionStore')
ServerAPIBridge = require('../utils/ServerAPIBridge')

ESCAPE_KEY = 27


module.exports = React.createClass
  propTypes:
    help: React.PropTypes.string.isRequired
    onCancel: React.PropTypes.func.isRequired
    onSubmit: React.PropTypes.func.isRequired

  getInitialState: ->
    return { callee: @props.callee }

  identityNVPairs: ->
    seedIdentityNVPairs = [{value: '', name: @props.help}, {value: 'Cancel', name: 'Cancel'}]
    identities = IdentitiesStore.getIdentities()
    console.log identities
    identities.splice identities.indexOf(SessionStore.getIdentity()), 1
    identitiesAsNVPairs = for identity in identities
      {name: identity, value: identity}
    seedIdentityNVPairs.concat identitiesAsNVPairs

  _onChange: (event)->
    callee = undefined
    if event and (event.keyCode isnt ESCAPE_KEY)
      callee = event.target.value

    @setState({ callee: callee, identities: @identityNVPairs() })
    console.log "changed. callee: #{callee}"
    return unless callee
    if callee is '' or callee is 'Cancel'
      @props.onCancel()
    else
      @props.onSubmit(callee)

  componentDidMount: ->
    IdentitiesStore.addChangeListener(@_onChange)
    ServerAPIBridge.getLobby()

  componentWillUnmount: ->
    IdentitiesStore.removeChangeListener(@_onChange)

  render: ->
    options = for identity in @identityNVPairs()
      (<option key={identity.name} value={identity.value}>{identity.name}</option>)

    return (
      <div className="call">
        <form onSubmit={@_onSubmit}>
          <select onChange={@_onChange} onKeyDown={@_onChange} value={@state.callee}>
           {options}
         </select>
       </form>
      </div>
    )
