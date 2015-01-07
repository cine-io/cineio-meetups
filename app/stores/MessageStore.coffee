assign = require("object-assign")
EventEmitter = require("events").EventEmitter

AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")

ActionTypes = MainConstants.ActionTypes
CHANGE_EVENT = "change"

_messages = null

reset = ->
  _messages = []

reset()

MessageStore = assign {}, EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  ###*
  @param {function} callback
  ###
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

  getMessages: ->
    _messages.slice(0) #clone

  clearMessages: ->
    reset()
    @emitChange()

MessageStore.dispatchToken = AppDispatcher.register((payload) ->
  action = payload.action
  switch action.type
    when ActionTypes.NEW_MESSAGE
      console.log("NEW_MESSAGE", action.message)
      _messages.push action.message
      # AppDispatcher.waitFor [MessageStore.dispatchToken]
      MessageStore.emitChange()
    when ActionTypes.CREATE_MESSAGE
      console.log("CREATE_MESSAGE", action.message)
      action.message.identity ||= 'Me'
      _messages.push action.message
      # AppDispatcher.waitFor [MessageStore.dispatchToken]
      MessageStore.emitChange()
    when ActionTypes.LEAVE_ROOM, ActionTypes.CALL_HANGUP, ActionTypes.CALL_CANCELED
      console.log("LEAVE_ROOM", action.message)
      reset()
      MessageStore.emitChange()
    when ActionTypes.INSTALL_EXTENSION
      console.log("INSTALL_EXTENSION")
      message = {identity: 'system', timestamp: new Date, text: "Please install the #{action.extensionType} extension to share your screen: #{action.url}."}
      _messages.push(message)
      MessageStore.emitChange()
    else
)

# do nothing
module.exports = MessageStore
