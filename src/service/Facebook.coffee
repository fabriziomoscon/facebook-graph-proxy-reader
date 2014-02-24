request = require 'request'

module.exports = (config) ->

  return request("https://graph.facebook.com/#{config.facebook.graphId}/feed?access_token=#{config.facebook.accessToken}")
