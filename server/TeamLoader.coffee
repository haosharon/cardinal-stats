
Meteor.methods(
  getConfigurations: ->
    configJSON = Assets.getText('config.json')
    return configJSON
  )
