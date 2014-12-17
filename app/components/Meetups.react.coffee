# @cjsx React.DOM

React = require('react')
MainVideo = require('./MainVideo.react')
Controls = require('./Controls.react')
SmallVideos = require('./SmallVideos.react')
TextChat = require('./TextChat.react')

module.exports = React.createClass({

  render: ->
    return (
      <div id="meetups">
        <div id="video-chat">
          <MainVideo />
          <SmallVideos />
        </div>
        <div id="text-chat">
          <Controls />
          <TextChat />
        </div>
      </div>
    )

})
