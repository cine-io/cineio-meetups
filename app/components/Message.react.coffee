# @cjsx React.DOM
React = require('react')
moment = require('moment')

module.exports = React.createClass

  propTypes:
    message: React.PropTypes.object.isRequired

  render: ->
    d = new Date(@props.message.timestamp)

    time = moment(d).format('h:mm A')
    return (
      <div className="message">
        <div className="top">
          <div className="identity">
            {@props.message.identity}
          </div>
          <div className="time">
            {time}
          </div>
        </div>
        <div className="body">
          {@props.message.text}
        </div>
      </div>
    )
