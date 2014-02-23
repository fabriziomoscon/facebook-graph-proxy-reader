http = require 'http'
request = require 'request'

config = require './src/config/environment'

server = http.createServer (req, res) ->

  request("https://graph.facebook.com/#{config.facebook.graphId}/feed?access_token=#{config.facebook.accessToken}")
    .pipe(res)

server.listen config.server.listen.port, config.server.listen.host, () ->
  console.log {server: server.address()}, 'listening'
