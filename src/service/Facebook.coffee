url        = require 'url'
hyperquest = require 'hyperquest'


class Facebook


  @URL = 'https://graph.facebook.com/'


  constructor: (config) ->
    @config = config


  fetch: (callback) ->

    facebookUrl = url.format {
      protocol: 'https:', 
      host: "graph.facebook.com/#{@config.facebook.graphId}"
      pathname: 'feed'
      query: {
        access_token: @config.facebook.accessToken
      }
    }

    req = hyperquest.get(facebookUrl)

    req.on 'error', callback
    req.on 'response', (res) ->

      res.on 'error', callback

      facebookData = ''
      res.on 'data', (chunk) -> facebookData += chunk
      res.on 'end', () -> 

        try facebookData = JSON.parse facebookData
        catch error
          #TODO make this error nicer - e.g error parsing json
          return callback error

        unless facebookData?.data?
          return callback new Error 'Invalid response'

        if facebookData.error?.message?
          return callback new Error facebookData.error.message

        return callback null, facebookData.data

    return



module.exports = Facebook
