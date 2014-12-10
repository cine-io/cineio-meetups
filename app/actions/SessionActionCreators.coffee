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

  callAnswered: (call)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL_ANSWERED
      call: call

  callRejected: (call)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL_REJECTED
      call: call

  callHangup: (call)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CALL_HANGUP
      call: call

  mute: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.MUTE
    CineAPIBridge.mute()

  unmute: ->
    AppDispatcher.handleViewAction
      type: ActionTypes.UNMUTE
    CineAPIBridge.unmute()

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
