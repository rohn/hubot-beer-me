# Description:
#   Retrieve a beer's info from Beer Advocate
#
# Dependencies:
#   'beer-advocate-api': '0.0.6'
#
# Commands:
#   hubot beer me <query> - searches for and returns info for a beer
#
# Author:
#   @rohn

ba = require('beer-advocate-api')

module.exports = (robot) ->
  robot.respond /(beer)( me)? (.*)/i, (msg) ->
    beerMe msg, msg.match[3]

beerMe = (msg, query) ->
  ba.beerSearch query, (beers) ->
    allBeers = JSON.parse(beers)
    if allBeers.length
      firstBeer = allBeers[Math.floor(Math.random() * allBeers.length)]
      ba.beerPage firstBeer.beer_url, (beer) ->
        theBeer = JSON.parse(beer)[0]
        theUrl = 'http://beeradvocate.com' + firstBeer.beer_url
        msg.send "#{theBeer.brewery_name}\n
          #{theBeer.beer_name}\n
          Style: #{theBeer.beer_style}\n
          ABV: #{theBeer.beer_abv}\n
          Rating: #{theBeer.ba_score}\n
          #{theUrl}"
    else
      msg.send "I couldn't find that one"