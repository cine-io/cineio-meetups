# @cjsx React.DOM
React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')

module.exports = React.createClass
  propTypes:
    call: React.PropTypes.object.isRequired

  answer: (event)->
    event.preventDefault()
    @props.call.answer()
    SessionActionCreators.answerCall(@props.call)

  reject: (event)->
    event.preventDefault()
    @props.call.reject()
    SessionActionCreators.rejectCall(@props.call)

  render: ->
    return (
      <ul className='incoming-call'>
        <li>
          <button onClick={@answer}>Answer</button>
        </li>
        <li>
          <button onClick={@reject}>Reject</button>
        </li>
      </ul>
    )

