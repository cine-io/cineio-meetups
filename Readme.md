# cine.io Meetups (Google Hangouts clone)

This app demonstrates the [cine.io Peer SDK][peer]. It provides real time
video/audio/text chat using rooms and peer-to-peer calling.

## Demo

We have this exact app up and running on [https://meetups.cine.io/][meetups].
Please note that the demo requires a compatible browser (Firefox > 34.0 /
Chrome > 38.0). Also note that if you are using Chrome and want to use the
screen-sharing functionality, you should install the
[cine.io Screen Sharing extension][chrome-extension].

## App Architecture

This is a [Node.js][node], [React.js][react], and [flux][] based web app that
uses the [cine.io Peer SDK][peer-sdk] client to create a google hangouts
clone.

### Cine Peer Code Walk-through

[CineAPIBridge][] is the section of code that interacts with the
[cine.io Peer SDK][peer-sdk] and triggers actions in the [CineActionCreators][]
action creator.

[CineAPIBridge.init in app][] initializes all of the event listeners from the
peer client.

[ServerAPIBridge.identify][] fetches the secure identity signature required
to securly identify on the cine signaling server. This is __NOT__ how this
should be done in a production application. This is meant to simulate a user
logging in and getting their secure identity signature associated with their
user id. In a production application, only return the correct secure identity
signature which is appropriate for each individual user. The lobby is a simple
in memory store of who is currently "logged in" to the site. The lobby acts as
a phone book and is implemented in the simplest way to demonstrate calling
from one user to another.

The [MessageStore][] simply stores all the peer to peer messages.

The [SessionStore][] stores the active call, which room you are in, your
identity, if you have your webcam started, your microphone started, and your
screen share started.

The [IdentitiesStore][] stores all of the other logged in users. It is simply a
phone book of other users to demonstrate the calling functionality of the
[cine.io Peer SDK][peer-sdk].

[Meetups.react][] is the entry point to the react view. It holds the main video,
small videos, controls and chat.

## Running Without SSL (screen-sharing won't work)

Create a `.env` file:

```
CINE_IO_PUBLIC_KEY= cine.io production public key
CINE_IO_SECRET_KEY= cine.io production secret key
PORT=9080
NODE_ENV=development
```

Start using [foreman][]:

```bash
foreman run coffee server.coffee
```

## Running With SSL (required for screen-sharing)

SSL is required for screen sharing. This is pretty hardcoded to work with our
own SSL certificates. But you can modify [create_cine_https_server.coffee][]
to use your own self-signed SSL certs.

Create a `.env` file:

```
CINE_IO_PUBLIC_KEY= cine.io production public key
CINE_IO_SECRET_KEY= cine.io production secret key
SSL_CERTS_PATH=../peer-client/ignored/certificates
PORT=9080
SSL_PORT=9443
NODE_ENV=development
```


Start using [foreman][]:

```bash
foreman run coffee server.coffee
```


<!-- links -->

[peer]:https://www.cine.io/products/peer
[meetups]:https://meetups.cine.io/
[chrome-extension]:https://chrome.google.com/webstore/detail/cineio-screen-sharing/ancoeogeclfnhienkmfmeeomadmofhmi?hl=en-US
[node]:http://nodejs.org/
[react]:http://facebook.github.io/react/
[flux]:https://facebook.github.io/flux/
[peer-sdk]:https://github.com/cine-io/peer-js-sdk
[foreman]:https://github.com/ddollar/foreman

<!-- meetups code links -->

[CineAPIBridge]:https://github.com/cine-io/cineio-meetups/blob/master/app/utils/CineAPIBridge.coffee
[CineActionCreators]:https://github.com/cine-io/cineio-meetups/blob/master/app/actions/CineActionCreators.coffee
[CineAPIBridge.init in app]:https://github.com/cine-io/cineio-meetups/blob/master/app/app.coffee#L14
[ServerAPIBridge.identify]:https://github.com/cine-io/cineio-meetups/blob/master/app/utils/ServerAPIBridge.coffee#L15-16
[MessageStore]:https://github.com/cine-io/cineio-meetups/blob/master/app/stores/MessageStore.coffee
[SessionStore]:https://github.com/cine-io/cineio-meetups/blob/master/app/stores/SessionStore.coffee
[IdentitiesStore]:https://github.com/cine-io/cineio-meetups/blob/master/app/stores/IdentitiesStore.coffee
[Meetups.react]:https://github.com/cine-io/cineio-meetups/blob/master/app/components/Meetups.react.coffee
[create_cine_https_server.coffee]:https://github.com/cine-io/cineio-meetups/blob/master/create_cine_https_server.coffee

