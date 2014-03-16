// ./set-env test node ./src/integration/generate_refresh_token.js

var config = require('../config/environment');

var readline = require('readline');

var googleapis = require('googleapis');
var OAuth2Client = googleapis.OAuth2Client;

// Client ID and client secret are available at
// https://code.google.com/apis/console
var CLIENT_ID = config.youtube.client["id"];
var CLIENT_SECRET = config.youtube.client.secret;
var REDIRECT_URL = config.youtube.client.redirectURL;

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var opts = {
  access_type: 'offline', // will return a refresh token
  scope: 'https://www.googleapis.com/auth/youtube',
  approval_prompt: 'force'
}

function getAccessToken(oauth2Client, callback) {
  // generate consent page url
  var url = oauth2Client.generateAuthUrl(opts);

  console.log('Visit the url: ', url);
  rl.question('Enter the code here:', function(code) {
    // request access token
    oauth2Client.getToken(code, function(err, tokens) {
      // set tokens to the client
      // TODO: tokens should be set by OAuth2 client.
      console.log('tokens', tokens);
      oauth2Client.setCredentials(tokens);
      callback();
    });
  });
}

function listPlaylists(client, authClient, callback) {
  client
    .youtube.playlists.list({
      "part": "snippet",
      "mine": true
    })
    .withAuthClient(authClient)
    .execute(callback);
}

// load google plus v1 API resources and methods
googleapis
  .discover('youtube', 'v3')
  .execute(function(err, client) {

    var oauth2Client = new OAuth2Client(CLIENT_ID, CLIENT_SECRET, REDIRECT_URL, opts);

    // retrieve an access token
    getAccessToken(oauth2Client, function() {
      // retrieve user profile
      listPlaylists(client, oauth2Client, function(err, result) {
        if (err) {
          console.log('An error occured', err);
          return;
        }
        console.log(result);
      });
    });

});
