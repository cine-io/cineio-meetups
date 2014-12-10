CineActionCreators = require('../actions/CineActionCreators')

CineAPIBridge =

  joinRoom: (name)->
    CineIOPeer.join(name)

  leaveRoom: (name)->
    CineIOPeer.leave(name)

  init: ->
    CineIOPeer.on 'mediaRejected', (data)->
      alert('Permission denied.')

    CineIOPeer.on 'error', (err)->
      if (typeof(err.support) != "undefined" && !err.support)
        alert("This browser does not support WebRTC.</h1>")
      else if (err.msg)
        alert(err.msg)

    CineIOPeer.on 'call', (data)->
      console.log("NEW CALL")
      # data.call.answer()

    CineIOPeer.on 'mediaAdded', (data)->
      console.log("Media added")
      if data.local
        CineActionCreators.localWebcamStarted(data.videoElement)
      else
        console.log("REMOTE PEERRRR")
        CineActionCreators.newPeer(data.videoElement)

    CineIOPeer.on 'mediaRemoved', (data)->
      console.log("Media added")
      if data.local
        CineActionCreators.localWebcamRemoved(data.videoElement)
      else
        console.log("REMOTE PEERRRR")
        CineActionCreators.peerLeft(data.videoElement)

    CineIOPeer.startCameraAndMicrophone CineAPIBridge.stared

module.exports = CineAPIBridge
