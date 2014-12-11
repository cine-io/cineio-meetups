AppDispatcher = require('../dispatcher/AppDispatcher');
MainConstants = require('../constants/MainConstants');
# ChatWebAPIUtils = require('../utils/ChatWebAPIUtils');
# MessageStore = require('../stores/MessageStore');

ActionTypes = MainConstants.ActionTypes;

module.exports =

  localWebcamStarted: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.LOCAL_WEBCAM_STARTED
      video: video

  localWebcamRemoved: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.LOCAL_WEBCAM_REMOVED
      video: video

  localScreenShareStarted: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.LOCAL_SCREEN_SHARE_STARTED
      video: video

  localScreenShareRemoved: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.LOCAL_SCREEN_SHARE_REMOVED
      video: video

  newPeer: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.NEW_PEER
      video: video

  newCall: (call)->
    AppDispatcher.handleCineAction
      type: ActionTypes.INCOMING_CALL
      call: call

  currentCall: (call)->
    AppDispatcher.handleCineAction
      type: ActionTypes.OUTGOING_CALL
      call: call

  callRejected: (call)->
    AppDispatcher.handleCineAction
      type: ActionTypes.CALL_REJECTED
      call: call

  peerLeft: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.PEER_LEFT
      video: video

  gotPeerData: (data)->
    if data.type == 'message'
      AppDispatcher.handleCineAction
        type: ActionTypes.NEW_MESSAGE
        message: data
    # useless else
    else
      return
