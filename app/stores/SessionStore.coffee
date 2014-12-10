assign = require("object-assign")
EventEmitter = require("events").EventEmitter

AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")

CHANGE_EVENT = "change"

ActionTypes = MainConstants.ActionTypes
CHANGE_EVENT = "change"

_room = null
_identity = null
_audioMuted = false
_videoMuted = false
_screenShareStarted = false

SessionStore = assign {}, EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT


  ###*
  @param {function} callback
  ###
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

  # get: (id) ->
  #   _messages[id]

  getCurrentRoom: ->
    _room

  getIdentity: ->
    _identity

  videoMuted: ->
    _videoMuted

  audioMuted: ->
    _audioMuted

  screenShareStarted: ->
    _screenShareStarted

console.log("SETTING DISPATCHER")
SessionStore.dispatchToken = AppDispatcher.register((payload) ->
  action = payload.action
  switch action.type
    when ActionTypes.JOIN_ROOM
      console.log("Joining room", action.room)
      _room = action.room
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.LEAVE_ROOM
      console.log("LEAVING room", action.room)
      _room = null
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.SET_IDENTITY
      console.log("SET_IDENTITY", action.room)
      _identity = action.identity
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.LOCAL_WEBCAM_STARTED
      console.log("LOCAL_WEBCAM_STARTED", action.video)
      _audioMuted = false
      _videoMuted = false
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.MUTE_AUDIO
      _audioMuted = true
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.UNMUTE_AUDIO
      _audioMuted = false
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.MUTE_VIDEO
      _videoMuted = true
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.UNMUTE_VIDEO
      _videoMuted = false
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.START_SCREEN_SHARE
      _screenShareStarted = true
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.STOP_SCREEN_SHARE
      _screenShareStarted = false
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    else
)

# do nothing
module.exports = SessionStore
