# ./set-env test coffee ./src/integration/youtube.coffee

config = require '../config/environment'

googleapis = require 'googleapis'

oauth2client = new googleapis.auth.OAuth2(
  config.youtube.client.id
  config.youtube.client.secret
  config.youtube.client.redirectURL
  {
    "access_type": "offline"
    "approval_prompt": "force"
    # "scope": ['https://www.googleapis.com/auth/youtube', 'https://www.googleapis.com/auth/youtube.upload']
    "scope": 'https://www.googleapis.com/auth/youtube'
    "grant_type": "refresh_token"
  }
)

oauth2client.credentials = { "refresh_token": config.youtube.client.refreshToken }

googleapis
  .discover('youtube', 'v3')
  .withAuthClient(oauth2client)
  .execute( (err, client) ->
    if err?
      console.log "ERROR", err
      process.exit 1
    
    console.log "Youtube API client", client

    client
      .withAuthClient(oauth2client)
      # .youtube.videos.rate( {id: 'Lg_85hMxBv8', rating: 'unlike' })
      # .youtube.channels.list({mine: true, part: 'contentDetails'})
      # .youtube.search.list(
      #   q: 'BBC documentary',
      #   part: 'snippet'
      # )
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
      #     "mine": true
      #   }
      # )
      .execute( (err, res) ->
        if err?
          console.log "ERROR", err
          process.exit 1

        console.log 'RESULT', res
      )
  )
