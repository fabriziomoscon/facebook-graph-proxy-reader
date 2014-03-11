# ./set-env test coffee ./src/integration/youtube.coffee

config = require '../config/environment'

googleapis = require 'googleapis'

JWT = googleapis.auth.JWT

jwtAuthClient = new JWT(
  config.youtube.client.email
  config.youtube.client.privatekeypath
  null
  ['https://www.googleapis.com/auth/youtube', 'https://www.googleapis.com/auth/youtube.upload', 'https://www.googleapis.com/auth/youtubepartner']
)

jwtAuthClient.authorize (err, result) ->
  if err?
    console.log "ERROR", err
    process.exit 1

  console.log "Authorize result", result

  googleapis
    .discover('youtube', 'v3')
    .withAuthClient(jwtAuthClient)
    .execute( (err, client) ->
      if err?
        console.log "ERROR", err
        process.exit 1
      
      console.log "Youtube API client", client

      client
        #not working
        # .youtube.videos.rate( {id: 'Lg_85hMxBv8', rating: 'like' })
        # .youtube.channels.list({mine: true, part: 'contentDetails'})

        #working
        # .youtube.search.list(
        #   q: 'BBC documentary',
        #   part: 'snippet'
        # )

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
        # .youtube.playlists.list(
        #   {
        #     "part": "snippet"
        #     "channelId": config.youtube.channelId
        #   }
        # )
        .execute( (err, res) ->
          if err?
            console.log "ERROR", err
            process.exit 1

          console.log 'RESULT', res
        )
    )
