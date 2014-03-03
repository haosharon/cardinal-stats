Logs = []

Meteor.methods(
    getConfigurations: ->
        configJSON = Assets.getText('config.json')
        return configJSON

    log: (log) ->
        Logs.push(log)
        # _.forEach(Logs, (log) ->
        #     console.log log
        #     )
  )
