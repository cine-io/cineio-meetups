# @cjsx React.DOM

React = require('react')
MainVideo = require('./MainVideo.react')
Controls = require('./Controls.react')
SmallVideos = require('./SmallVideos.react')

module.exports = React.createClass({

  render: ->
    return (
      <div id="example">
        <Controls/>
        <MainVideo/>
        <SmallVideos/>
      </div>
    )


})
