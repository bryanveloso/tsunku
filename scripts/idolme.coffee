# Idols are here to make you happy.
#
# idol me - Receive a pug
# idol bomb N - get N pugs (not yet though.)

module.exports = (robot) ->

  robot.respond /idol me/i, (msg) ->
    msg.http("http://aidoru-bomb.herokuapp.com/random")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).idol

  robot.respond /pug bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.http("http://aidoru-bomb.herokuapp.com/bomb")
    # msg.http("http://pugme.herokuapp.com/bomb?count=" + count)
      .get() (err, res, body) ->
        msg.send idol for idols in JSON.parse(body).idols

  robot.respond /how many idols are there/i, (msg) ->
    msg.http("http://aidoru-bomb.herokuapp.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).count} idols."
