facebook = new (require 'src/service/Facebook')
youtube = new (require 'src/service/Youtube')

forwardVideo = () ->
  data = facebook.fetch()
  # dedup

  for video in data
    youtube.postToPlaylist(video)
  

setInterval(
  forwardVideo
  60000 # 1 minute
)
