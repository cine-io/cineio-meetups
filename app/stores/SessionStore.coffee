assign = require("object-assign")
EventEmitter = require("events").EventEmitter

AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")

CHANGE_EVENT = "change"

ActionTypes = MainConstants.ActionTypes
CHANGE_EVENT = "change"

_room = null
_identity = null
_muted = false

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
    console.log("returing current room", _room)
    _room

  getIdentity: ->
    _identity
  muted: ->
    _muted

console.log("SETTING DISPATCHER")
SessionStore.dispatchToken = AppDispatcher.register((payload) ->
  console.log("GOT PAYLOAD", payload)
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
    when ActionTypes.MUTE
      _muted = true
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    when ActionTypes.UNMUTE
      _muted = false
      # AppDispatcher.waitFor [SessionStore.dispatchToken]
      SessionStore.emitChange()
    else
)

# do nothing
module.exports = SessionStore
