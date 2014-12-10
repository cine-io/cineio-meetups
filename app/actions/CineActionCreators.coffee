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

  newPeer: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.NEW_PEER
      video: video

  peerLeft: (video)->
    AppDispatcher.handleCineAction
      type: ActionTypes.PEER_LEFT
      video: video
