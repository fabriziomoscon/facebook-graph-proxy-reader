config = require '../config/environment'

googleapis = require 'googleapis'

JWT = googleapis.auth.JWT


jwtAuthClient = new JWT(
  config.youtube.client.email
  config.youtube.client.privatekeypath
  null
  ['https://www.googleapis.com/auth/youtube', 'https://www.googleapis.com/auth/youtubepartner']
)

jwtAuthClient.authorize (err, result) ->
  console.log err
  console.log result

  googleapis
    .discover('youtube', 'v3')
    .withAuthClient(jwtAuthClient)
    .execute( (err, client) ->
      console.log err
      console.log client

      client
        # .youtube.videos.rate( {id: 'OQfjIw3mivc', rating: 'like' })
        # .youtube.channels.list({mine: true, part: 'contentDetails'})
        .youtube.playlistItems.insert(
          { part: "snippet" },
          {
            snippet:
              playlistId: config.youtube.playlistId
              resourceId:
                kind: "youtube#video"
                videoId: "Lg_85hMxBv8"
          }
        )
        # .youtube.playlists.list(
        #   {
        #     "part": "snippet"
        #     "channelId": config.youtube.channelId
        #   }
        # )
        .execute( (err, res) ->
          console.log err
          console.log res
        )
    )
