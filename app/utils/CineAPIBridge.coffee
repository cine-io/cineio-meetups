CineActionCreators = require('../actions/CineActionCreators')

CineAPIBridge =

  _handleOutgoingCall: (err, data)->
    debugger
    callObj = data.call
    CineActionCreators.currentCall(callObj)
    callObj.on 'call-reject', ->
      CineActionCreators.callRejected(callObj)

  joinRoom: (name)->
    CineIOPeer.join(name)

  leaveRoom: (name)->
    CineIOPeer.leave(name)

  identify: (data)->
    CineIOPeer.identify(data.identity, data.timestamp, data.signature)

  call: (identity, options={})->
    if options.call
      options.call.invite(identity)
    else if options.room
      CineIOPeer.call identity, options.room, CineAPIBridge._handleOutgoingCall
    # unnecessary else, but helpful verbosity
    else
      CineIOPeer.call identity, CineAPIBridge._handleOutgoingCall

  sendDataToAll: (data)->
    console.log("CineAPIBridge sendDataToAll", data)
    CineIOPeer.sendDataToAll(data)

  startCameraAndMicrophone: ->
    console.log("CineAPIBridge startCameraAndMicrophone")
    CineIOPeer.startCameraAndMicrophone()

  muteAudio: ->
    console.log("CineAPIBridge muteAudio")
    CineIOPeer.stopMicrophone()

  unmuteAudio: ->
    console.log("CineAPIBridge unmuteAudio")
    CineIOPeer.startMicrophone()

  muteVideo: ->
    console.log("CineAPIBridge muteVideo")
    CineIOPeer.stopCamera()

  startScreenShare: ->
    console.log("CineAPIBridge startScreenShare")
    CineIOPeer.startScreenShare()

  stopScreenShare: ->
    console.log("CineAPIBridge stopScreenShare")
    CineIOPeer.stopScreenShare()

  unmuteVideo: ->
    console.log("CineAPIBridge unmuteVideo")
    CineIOPeer.startCamera()

  init: ->
    CineIOPeer.on 'media-rejected', (data)->
      alert('Permission denied.')

    CineIOPeer.on 'error', (err)->
      if (typeof(err.support) != "undefined" && !err.support)
        alert("This browser does not support WebRTC.")
      else if (err.msg)
        alert(err.msg)

    CineIOPeer.on 'call', (data)->
      console.log("NEW CALL", data)
      CineActionCreators.newCall(data.call)

    CineIOPeer.on 'peer-data', (data)->
      console.log("GOT DATA CALL", data)
      CineActionCreators.gotPeerData(data)
      # data.call.answer()

    CineIOPeer.on 'media-added', (data)->
      console.log("Media added")
      if data.local
        if data.type == 'camera'
          CineActionCreators.localWebcamStarted(data.videoElement)
        else if data.type == 'screen'
          CineActionCreators.localScreenShareStarted(data.videoElement)
      else
        console.log("REMOTE PEERRRR")
        CineActionCreators.newPeer(data.videoElement)

    CineIOPeer.on 'media-removed', (data)->
      console.log("Media removed")
      if data.local
        if data.type == 'camera'
          CineActionCreators.localWebcamRemoved(data.videoElement)
        else if data.type == 'screen'
          CineActionCreators.localScreenShareRemoved(data.videoElement)
      else
        console.log("REMOTE PEERRRR")
        CineActionCreators.peerLeft(data.videoElement)

    CineAPIBridge.startCameraAndMicrophone()

module.exports = CineAPIBridge
