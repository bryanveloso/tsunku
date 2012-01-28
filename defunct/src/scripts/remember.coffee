# Remembers a key and value.
#
# hubot remember <key> - Returns a string
# hubot remember <key> is <value>. - Returns nothing. Remembers the text for next time!
# hubot what do you remember - Returns everything hubot remembers
# hubot forget <key> - Removes key from hubots brain

module.exports = (robot) ->
  robot.respond /remember\s+(.*)/i, (msg) ->
    words = msg.match[1]
    if words == 'me'
      msg.finish()
      robot.brain.data.remember ?= {}
      keys = []
      for own key, value of robot.brain.data.remember
        keys.push key
      key = msg.random(keys)
      msg.send key
      msg.send robot.brain.data.remember[key]
    else if match = words.match /(.*?)(\s+is\s+(.*))$/i
      key = match[1].toLowerCase()
      value = match[3]
      robot.brain.data.remember ?= {}
      robot.brain.data.remember[key] = value
      msg.send "OK, I'll remember #{key}."
    else if match = words.match /([^?]+)\??/i
      msg.finish()
      key = match[1].toLowerCase()
      value = robot.brain.data.remember?[key]
      msg.send value or "I don't remember #{key}."

  robot.respond /forget\s+(.*)/i, (msg) ->
    key = msg.match[1].toLowerCase()
    value = robot.brain.data.remember[key]
    delete robot.brain.data.remember[key]
    msg.send "I've forgotten #{key} is #{value}."

  robot.respond /what do you remember/i, (msg) ->
    msg.finish()
    keys = []
    keys.push key for key of robot.brain.data.remember
    msg.send "I remember #{keys.join(', ')}."
