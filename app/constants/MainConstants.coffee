keyMirror = require('keymirror')

module.exports =
  ActionTypes: keyMirror
    SET_IDENTITY: null
    CALL: null
    INCOMING_CALL: null
    CALL_ANSWERED: null
    CALL_REJECTED: null
    INCOMING_CALL_REJECTED: null
    CALL_HANGUP: null
    INVITE: null
    OUTGOING_CALL: null
    JOIN_ROOM: null
    NEW_PEER: null
    PEER_LEFT: null
    MUTE: null
    UNMUTE: null
    LOCAL_WEBCAM_STARTED: null
  PayloadSources: keyMirror
    CINE_ACTION: null
    VIEW_ACTION: null
