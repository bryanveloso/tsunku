# Pony Business Operation
#
# Uses the My Little Face When API to fetch
# pictures of ponies and make me happy.
#
# Hubot pony me a pinkie pie
# Hubot pony me some haters gonna hate
#
# NOTE: we need to fake an User-Agent because
# the pony-API is dumb

module.exports = (robot) ->
  robot.respond /(pony)( me)?( a| some)? (.*)/i, (msg) ->
    tags = [msg.match[4]]
    msg.http('http://mylittlefacewhen.com')
    .header('User-Agent',
      'curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8r zlib/1.2.5')
    .header('Accept', '*/*')
    .path('/api/search/')
    .query(tags: JSON.stringify(tags))
    .get() (err, res, body) ->
      images = JSON.parse(body)
      img  = msg.random images
      msg.send img.image if img
