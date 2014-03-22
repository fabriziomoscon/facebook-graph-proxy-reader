googleapis = require 'googleapis'


class Youtube


  constructor: (config) ->
    @oauth2client = new googleapis.auth.OAuth2(
      config.youtube.client.id
      config.youtube.client.secret
      config.youtube.client.redirectURL
      {
        "access_type": "offline"
        "approval_prompt": "force"
        "scope": 'https://www.googleapis.com/auth/youtube'
        "grant_type": "refresh_token"
      }
    )

    @oauth2client.credentials = { "refresh_token": config.youtube.client.refreshToken }


  addToPlaylist: (playlistId, videoId, callback) ->

    googleapis
      .discover( 'youtube', 'v3' )
      .withAuthClient( @oauth2client )
      .execute( (err, client) ->
        if err?
          return callback err

        client
          .youtube.playlistItems.insert(
            { part: "snippet" },
            {
              snippet:
                playlistId: playlistId
                resourceId:
                  videoId: videoId
                  kind: "youtube#video"
            }
          )
          .execute( callback )
      )


module.exports = Youtube
