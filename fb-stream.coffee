http = require 'http'
request = require 'request'

ACCESS_TOKEN = 'CAACEdEose0cBAJHLG9GJYiToFogGFYEq7ZAUYzQzOfOpfCqEsXDxC79hB020OSrJtzVcu9SxVbwnB6Mm8kPmxmmY9nmeMZAZBQEVuReD1gisshVbuUyLdOWLdZBca8IpA8WY9XkmMqVwIpg9JS6S1PXDPXVlxdWkjgjcfn3ORZCEesdUGZCZCwJMHcEDSbihlgZD'
nodeId = "569230849833126"

server = http.createServer (req, res) ->

  request("https://graph.facebook.com/#{nodeId}/feed?access_token=#{ACCESS_TOKEN}&fields=message")
    .pipe(res)

server.listen(8000)
