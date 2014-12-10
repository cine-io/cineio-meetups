# @cjsx React.DOM
React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')

module.exports = React.createClass
  propTypes:
    call: React.PropTypes.object.isRequired

  hangup: (event)->
    event.preventDefault()
    @props.call.hangup()
    SessionActionCreators.callHangup(@props.call)

  render: ->
    return (
      <ul>
        <li>
          <button onClick={@hangup}>Hangup</button>
        </li>
      </ul>
    )

