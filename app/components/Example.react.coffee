# @cjsx React.DOM

React = require('react')
MainVideo = require('./MainVideo.react')
Controls = require('./Controls.react')
SmallVideos = require('./SmallVideos.react')
TextChat = require('./TextChat.react')

module.exports = React.createClass({

  render: ->
    return (
      <div id="example">
        <div id="video-chat">
          <Controls />
          <MainVideo />
          <SmallVideos />
        </div>
        <div id="text-chat">
          <TextChat />
        </div>
      </div>
    )


})
