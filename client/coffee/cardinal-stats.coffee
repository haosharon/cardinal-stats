# if Meteor.isClient
#   Template.hello.greeting = ->
#     "Welcome to cardinal-stats."

#   Template.hello.events "click input": ->

#     # template data, if any, is available in 'this'
#     console.log "You pressed the button!!!"  if typeof console isnt "undefined"
#     return

# if Meteor.isServer
#   Meteor.startup ->


# # code to run on server at startup

root = exports ? this
Meteor.call('getConfigurations', (e, r) ->
    data = EJSON.parse(r)
    $(document).ready ->
        mainController = new root.MainController(
            statsContainer: $('.stats-container')
            resultsContainer: $('.results-container')
            data: data
        )
)