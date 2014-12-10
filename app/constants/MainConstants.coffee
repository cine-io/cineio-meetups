keyMirror = require('keymirror')

module.exports =
  ActionTypes: keyMirror
    SET_IDENTITY: null
    JOIN_ROOM: null
    NEW_PEER: null
    PEER_LEFT: null
    MUTE: null
    UNMUTE: null
    LOCAL_WEBCAM_STARTED: null
  PayloadSources: keyMirror
    CINE_ACTION: null
    VIEW_ACTION: null
