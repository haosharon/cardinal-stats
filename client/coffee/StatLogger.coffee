root = exports ? this

class root.StatLogger

    # logStat takes a single SingleStatValueModel as a parameter
    logStat: (stat) =>
        logLine = @buildLogLine(stat)
        data = {
            logged: true
            logLine: logLine
        }
        Meteor.call('log', logLine)

    buildLogLine: (stat) =>
        # a log line will be comma separated values:
        # player number, stat type, value
        if stat.get('statType') == 8 # SCORE
            # team score
            team = stat.get('team')
            statValue = stat.get 'value'
            time = (new Date()).getTime()
            return "#{team}, SCORE, #{statValue}, #{time}"
        else
            playerNumber = stat.playerNumber()
            statTypeString = stat.statTypeString()
            statValue = stat.get 'value'
            time = (new Date()).getTime()
            return "#{playerNumber}, #{statTypeString}, #{statValue}, #{time}"