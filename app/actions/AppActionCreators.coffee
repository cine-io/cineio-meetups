AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")

ActionTypes = MainConstants.ActionTypes

AppActionCreators =
  processLobby: (identities)->
    AppDispatcher.handleServerAction
      type: ActionTypes.ALL_IDENTITIES
      identities: identities

module.exports = AppActionCreators
