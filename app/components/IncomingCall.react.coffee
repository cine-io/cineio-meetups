# @cjsx React.DOM
React = require('react')
SessionActionCreators = require('../actions/SessionActionCreators')

module.exports = React.createClass
  propTypes:
    call: React.PropTypes.object.isRequired

  answer: (event)->
    event.preventDefault()
    SessionActionCreators.answerCall(@props.call)

  reject: (event)->
    event.preventDefault()
    SessionActionCreators.rejectCall(@props.call)

  render: ->
    return (
      <ul className='incoming-call'>
        <li>
          <button className="ok" onClick={@answer}><i className="fa fa-3x cine-phone"></i></button>
        </li>
        <li>
          <button className="cancel" onClick={@reject}><i className="fa fa-3x cine-hangup"></i></button>
        </li>
      </ul>
    )

