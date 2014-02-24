http = require 'http'


config = require './src/config/environment'

facebook = require './src/service/Facebook'

server = http.createServer (req, res) ->

  facebook(config).pipe(res)

server.listen config.server.listen.port, config.server.listen.host, () ->
  console.log {server: server.address()}, 'listening'
