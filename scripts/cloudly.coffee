# Post cloudly images.
#
# cl.ly url - will automatically post image

module.exports = (robot) ->
  robot.hear /(^http:\/\/[^\/]+\/(\w{4}|\w{20})$)/, (msg) ->
    msg.http(msg.match[1])
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          if json.content_url
            msg.send json.content_url
        catch error
