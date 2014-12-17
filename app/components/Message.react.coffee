# @cjsx React.DOM
React = require('react')
moment = require('moment')
autolinks = require('autolinks')

module.exports = React.createClass

  propTypes:
    message: React.PropTypes.object.isRequired

  identityBGClassName: ->
    identity = @props.message.identity
    # identityHas = first + middle + last
    identityHash = identity.charCodeAt(0) + identity.charCodeAt(Math.floor(identity.length / 2) - 1) + identity.charCodeAt(identity.length - 1)
    zeroToNine = identityHash % 10
    "bg#{zeroToNine}"

  render: ->
    d = new Date(@props.message.timestamp)

    time = moment(d).format('h:mm A')
    return (
      <div className="message">
        <div className="top">
          <div title={@props.message.identity} className="identity #{@identityBGClassName()}">
            {@props.message.identity[0]}
          </div>
          <div className="time">
            {time}
          </div>
          <div className="body" dangerouslySetInnerHTML={{ __html: autolinks(@props.message.text) }} />
        </div>
      </div>
    )
