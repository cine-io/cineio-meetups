AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")
CineAPIBridge = require("../utils/CineAPIBridge")

ActionTypes = MainConstants.ActionTypes

MessageActionCreators =
  createMessage: (message)->
    AppDispatcher.handleViewAction
      type: ActionTypes.CREATE_MESSAGE
      message: message
    CineAPIBridge.sendDataToAll(message)

module.exports = MessageActionCreators
