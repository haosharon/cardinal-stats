Logs = []

Meteor.methods(
    getConfigurations: ->
        configJSON = Assets.getText('config.json')
        return configJSON

    log: (log) ->
        console.log 'making a log!'
        Logs.push(log)
        _.forEach(Logs, (log) ->
            console.log log
            )
  )
