root = exports ? this

class root.StatLogger

    # logStat takes a single SingleStatValueModel as a parameter
    logStat: (stat) =>
        # for now, just console.log it
        logLine = @buildLogLine(stat)
        data = {
            logged: true
            logLine: logLine
        }
        $.ajax
            type: 'POST'
            url: 'php/logger.php'
            data: data
            success: (e) ->
                console.log 'logged success'


    buildLogLine: (stat) =>
        # a log line will be comma separated values:
        # player number, stat type, value
        playerNumber = stat.playerNumber()
        statTypeString = stat.statTypeString()
        statValue = stat.get 'value'
        time = (new Date()).getTime()
        return "#{playerNumber}, #{statTypeString}, #{statValue}, #{time}"