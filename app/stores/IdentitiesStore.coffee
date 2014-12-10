assign = require("object-assign")
EventEmitter = require("events").EventEmitter

AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")

CHANGE_EVENT = "change"

ActionTypes = MainConstants.ActionTypes

_identities = null

IdentitiesStore = assign {}, EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  ###*
  @param {function} callback
  ###
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

  getIdentitities: ->
    _identities

console.log("SETTING DISPATCHER")
IdentitiesStore.dispatchToken = AppDispatcher.register((payload) ->
  action = payload.action
  switch action.type
    when ActionTypes.ALL_IDENTITIES
      console.log("setting identities", action.identities)
      _identities = action.identities
      IdentitiesStore.emitChange()
    else
)

# do nothing
module.exports = IdentitiesStore
