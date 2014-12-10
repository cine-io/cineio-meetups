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

module.exports = SessionActionCreators
