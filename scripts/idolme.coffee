# Idols are here to make you happy.
#
# idol me - Receive an idol
# idol bomb N - get N idols

module.exports = (robot) ->

  robot.respond /idol me/i, (msg) ->
    msg.http("http://aidoru-bomb.herokuapp.com/random")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).idol

  robot.respond /idol bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.http("http://aidoru-bomb.herokuapp.com/bomb?count=" + count)
      .get() (err, res, body) ->
        msg.send idol for idol in JSON.parse(body).idols

  robot.respond /how many idols are there/i, (msg) ->
    msg.http("http://aidoru-bomb.herokuapp.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).count} idols."
