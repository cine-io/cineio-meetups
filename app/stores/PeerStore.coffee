assign = require("object-assign")
EventEmitter = require("events").EventEmitter

AppDispatcher = require("../dispatcher/AppDispatcher")
MainConstants = require("../constants/MainConstants")
{Howl} = require('howler')
CHANGE_EVENT = "change"

ActionTypes = MainConstants.ActionTypes
CHANGE_EVENT = "change"

_peers = []
_myVideo = null
_myScreenShare = null
_currentCall = null
_ringer = null
_mainVideo = null

startRing = ->
  _ringer = new Howl
    urls: ['/audio/ringer.ogg', '/audio/ringer.mp3']
    autoplay: true
    loop: true

stopRing = ->
  _ringer.stop()
  _ringer = null

PeerStore = assign {}, EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  ###*
  @param {function} callback
  ###
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

  getCurrentCall: ->
    _currentCall

  getOtherVideos: ->
    otherVideos = []
    mainVideo = PeerStore.getMainVideo()
    for peer in _peers
      otherVideos.push peer unless peer == mainVideo

    otherVideos.push _myVideo if _myVideo && _myVideo != mainVideo
    otherVideos.push _myScreenShare if _myScreenShare && _myScreenShare != mainVideo

    otherVideos

  getCameraStream: ->
    _myVideo

  getScreenShareStream: ->
    _myScreenShare

  getMainVideo: ->
    return _myVideo if _peers.length == 0
    # FANCY MAGIC ON WHO'S TALKING....
    _mainVideo ||= _peers[0]

PeerStore.dispatchToken = AppDispatcher.register((payload) ->
  action = payload.action
  switch action.type
    when ActionTypes.SELECT_VIDEO
      console.log("Setting mainVideo", action.video)
      _mainVideo = action.video
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.LOCAL_WEBCAM_STARTED
      console.log("Setting _myVideo", action.video)
      _myVideo = action.video
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.LOCAL_WEBCAM_REMOVED
      console.log("removing _myVideo", action.video)
      _myVideo = undefined
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.LOCAL_SCREEN_SHARE_STARTED
      console.log("Setting _myScreenShare", action.video)
      _myScreenShare = action.video
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.LOCAL_SCREEN_SHARE_REMOVED
      console.log("removing _myScreenShare", action.video)
      _myScreenShare = undefined
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.NEW_PEER
      console.log("adding Peer", action.video)
      _peers.push action.video
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.INCOMING_CALL
      console.log("incoming call", action.call)
      startRing()
      _currentCall = action.call
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.OUTGOING_CALL
      console.log("OUTGOING_CALL", action.call)
      _currentCall = action.call
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.CALL_HANGUP
      console.log("hung up", action.call)
      _currentCall = null
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.CALL_ANSWER
      console.log("call answered", action.call)
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      stopRing()
      PeerStore.emitChange()
    when ActionTypes.CALL_REJECT
      stopRing()
      _currentCall = null
      PeerStore.emitChange()
    when ActionTypes.CALL_REJECTED
      console.log("call rejected", action.call)
      _currentCall = null
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.CALL_CANCELED
      console.log("call canceled", action.call)
      _currentCall = null
      stopRing()
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    when ActionTypes.PEER_LEFT
      console.log("removing Peer", action.video)
      index = _peers.indexOf action.video
      _mainVideo = null if _mainVideo == action.video
      _peers.splice index, 1
      _currentCall = null if _peers.length == 0
      # _peers.push action.video
      # AppDispatcher.waitFor [PeerStore.dispatchToken]
      PeerStore.emitChange()
    else
)

# do nothing
module.exports = PeerStore
