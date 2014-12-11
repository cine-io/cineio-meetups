AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")
CineAPIBridge = require("../utils/CineAPIBridge")

ActionTypes = MainConstants.ActionTypes

PeerActionCreators =
  selectVideo: (video)->
    AppDispatcher.handleViewAction
      type: ActionTypes.SELECT_VIDEO
      video: video

module.exports = PeerActionCreators
