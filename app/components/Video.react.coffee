# @cjsx React.DOM

React = require('react')

module.exports = React.createClass

  render: ->
    return (<video src={@props.video.src} muted={@props.video.muted} autoPlay />)
