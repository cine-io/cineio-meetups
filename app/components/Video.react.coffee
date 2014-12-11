# @cjsx React.DOM
React = require('react')

module.exports = React.createClass

  propTypes:
    onClick: React.PropTypes.func

  render: ->
    return (<video src={@props.video.src} muted={@props.video.muted} autoPlay onClick={@props.onClick} />)
