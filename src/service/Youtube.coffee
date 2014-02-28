googleapis = require 'googleapis'

JWT = googleapis.auth.JWT



class Youtube


  constructor: (config) ->
    @jwtAuthClient = new JWT(
      config.youtube.client.email
      config.youtube.client.privatekeypath
      null
      ['https://www.googleapis.com/auth/youtube']
    )


  addToFavorites: (playlistId, videoId, callback) ->

    @jwtAuthClient.authorize (err, result) ->

      googleapis
        .discover('youtube', 'v3')
        .withAuthClient(@jwtAuthClient)
        .execute( (err, client) ->

          client
            #not working
            .youtube.playlistItems.insert(
              { part: "snippet" },
              {
                snippet:
                  playlistId: config.youtube.playlistId
                  resourceId:
                    videoId: "Lg_85hMxBv8"
                    kind: "youtube#video"
              }
            )
            .youtube.playlists.list(
              {
                "part": "snippet"
                "channelId": config.youtube.channelId
              }
            )
            .execute( callback )
        )




module.exports = Youtube
