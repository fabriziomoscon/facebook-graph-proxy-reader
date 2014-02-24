config = require '../config/environment'

googleapis = require 'googleapis'

JWT = googleapis.auth.JWT


jwtAuthClient = new JWT(
  config.youtube.client.email
  config.youtube.client.privatekeypath
  null
  ['https://www.googleapis.com/auth/youtube']
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
        .youtube.playlists.insert(
          {
            part: 'snippet'
            snippet:{
              title: 'Test Playlist'
              channelTitle: 'Radio Corighedrè'
            }
          }
        )
        .execute( (err, res) ->
          console.log err
          console.log res
        )
    )
