config = require './config/environment'

facebook = new (require './service/Facebook')(config)
youtube = new (require './service/Youtube')(config)

youtubeMapper = require './mapper/youtube'


forwardVideo = () ->
  facebook.fetch (err, data) ->

    if err?
      console.log err.message
      throw err
    # dedup

    if data?
      for post in data

        if post.type is 'video' and post.caption in ['youtu.be', 'www.youtube.com']
          youtube.addToPlaylist config.youtube.playlistId, youtubeMapper.extractId post.link, (err) ->
            if err?
              console.log err.message
            else
              console.log "VIDEO added to youtube: ", post.message
        
        if post.type is 'link' and post.caption in ['youtu.be', 'www.youtube.com']
          1
          # console.log post
          # youtube.addToPlaylist(config.youtube.playlistId, video.id)
        else
          1
          # console.log '=======>', post.type, post.caption
  

forwardVideo()
# setInterval(
#   forwardVideo
#   60000 # 1 minute
# )
