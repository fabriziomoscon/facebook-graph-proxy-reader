http = require 'http'
request = require 'request'

ACCESS_TOKEN = 'CAACEdEose0cBACAQOJxvYrSzT4cXTJ887ZAM6Cq3kZCPZBOKyEJPNi3gQr1XOWNvXfKZCkDzzmGZA0Lu9UzWdtM3pA9sfsNcUKxwkZBMOM0FeTIGQ4q80pXAZCYcTaJNt1YR3daxPS6vEGP3IKZAKwSQZAxpvefBgmrhmhMF6rNNwB0tniTaZBZBhbg7z4y8K7NjAIZD'
nodeId = "569230849833126"

server = http.createServer (req, res) ->

  request("https://graph.facebook.com/#{nodeId}/feed?access_token=#{ACCESS_TOKEN}")
    .pipe(res)

server.listen(8000)
