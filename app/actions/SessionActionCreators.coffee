AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")
CineAPIBridge = require("../utils/CineAPIBridge")

ActionTypes = MainConstants.ActionTypes

SessionActionCreators =
  joinRoom: (room)->
    AppDispatcher.handleViewAction
      type: ActionTypes.JOIN_ROOM
      room: room
    CineAPIBridge.joinRoom(room)

  leaveRoom: (room)->
    AppDispatcher.handleViewAction
      type: ActionTypes.LEAVE_ROOM
      room: room
    CineAPIBridge.leaveRoom(room)

  call: (identity)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL
      identity: identity
    CineAPIBridge.call(identity)

  invite: (identity, options)->
    AppDispatcher.handleViewAction
      type: ActionTypes.INVITE
      identity: identity
      room: options.room
      call: options.call
    CineAPIBridge.call(identity, room: options.room, call: options.call)

  answerCall: (call)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL_ANSWER
      call: call

  rejectCall: (call)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL_REJECT
      call: call

  callHangup: (call)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL_HANGUP
      call: call

  muteAudio: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.MUTE_AUDIO
    CineAPIBridge.muteAudio()

  unmuteAudio: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.UNMUTE_AUDIO
    CineAPIBridge.unmuteAudio()

  muteVideo: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.MUTE_VIDEO
    CineAPIBridge.muteVideo()

  unmuteVideo: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.UNMUTE_VIDEO
    CineAPIBridge.unmuteVideo()

  stopScreenShare: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.MUTE_VIDEO
    CineAPIBridge.stopScreenShare()

  startScreenShare: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.UNMUTE_VIDEO
    CineAPIBridge.startScreenShare()

  startCameraAndMicrophone: ->
    CineAPIBridge.startCameraAndMicrophone()

  identify: (name)->
    ServerAPIBridge.identify(name)

  secureIdentify: (data)->
    AppDispatcher.handleViewAction
      type: ActionTypes.SET_IDENTITY
      identity: data.identity
      timestamp: data.timestamp
      signature: data.signature
    CineAPIBridge.identify(data)

module.exports = SessionActionCreators

ServerAPIBridge = require("../utils/ServerAPIBridge")
