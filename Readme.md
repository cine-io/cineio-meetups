# cine.io Meetups (Google Hangouts clone)

This app demonstrates the [cine.io peer sdk](https://www.cine.io/products/peer). It provides real time video/audio/text chat using rooms and peer-to-peer calling.

## Demo

We have this exact app up and running on [https://meetups.cine.io/](https://meetups.cine.io/).

## App Architecture

This is a [Node.js](http://nodejs.org/), [flux](https://facebook.github.io/flux/), and [React](http://facebook.github.io/react/) based web app that uses the [cine.io peer sdk](https://github.com/cine-io/peer-js-sdk) client to create a google hangouts clone.

### Cine Peer code walkthrough

[CineAPIBridge](https://github.com/cine-io/cineio-meetups/blob/master/app/utils/CineAPIBridge.coffee) is the section of code that interacts with the [cine.io peer sdk](https://github.com/cine-io/peer-js-sdk) and triggers actions in the [CineActionCreators](https://github.com/cine-io/cineio-meetups/blob/master/app/actions/CineActionCreators.coffee) action creator.

[CineAPIBridge.init in app](https://github.com/cine-io/cineio-meetups/blob/master/app/app.coffee#L14) initializes all of the event listeners from the peer client.

[ServerAPIBridge.identify](https://github.com/cine-io/cineio-meetups/blob/master/app/utils/ServerAPIBridge.coffee#L15-16) fetches the secure identity signature required to securly identify on the cine signaling server. This is __NOT__ how this should be done in a production application. This is meant to simulate a user logging in and getting their secure identity signature associated with their user id. In a production application, only return the correct secure identity signature which is appropriate for each individual user. The lobby is a simple in memory store of who is currently "logged in" to the site. The lobby acts as a phone book and is implemented in the simplest way to demonstrate calling from one user to another.

The [MessageStore](https://github.com/cine-io/cineio-meetups/blob/master/app/stores/MessageStore.coffee) simply stores all the peer to peer messages.

The [SessionStore](https://github.com/cine-io/cineio-meetups/blob/master/app/stores/SessionStore.coffee) stores the active call, which room you are in, your identity, if you have your webcam started, your microphone started, and your screen share started.

The [IdentitiesStore](https://github.com/cine-io/cineio-meetups/blob/master/app/stores/IdentitiesStore.coffee) stores all of the other logged in users. It is simply a phone book of other users to demonstrate the calling functionality of the [cine.io peer sdk](https://www.cine.io/products/peer).

[Meetups.react](https://github.com/cine-io/cineio-meetups/blob/master/app/components/Meetups.react.coffee) is the entry point to the react view. It holds the main video, small videos, controls and chat.

## running locally

add a `.env` file
```
CINE_IO_PUBLIC_KEY= cine.io production public key
CINE_IO_SECRET_KEY= cine.io production secret key
PORT=9080
NODE_ENV=development
```

Start with: `foreman run coffee server.coffee`


## running in https

SSL is required for screen sharing. This is pretty hardcoded to work with my own ssl certs. But you can modify create_cine_https_server.coffee to use your own localhost ssl certs.

add a `.env` file
```
CINE_IO_PUBLIC_KEY= cine.io production public key
CINE_IO_SECRET_KEY= cine.io production secret key
SSL_CERTS_PATH=../peer-client/ignored/certificates
PORT=9080
SSL_PORT=9443
NODE_ENV=development
```

Start with: `foreman run coffee server.coffee`

