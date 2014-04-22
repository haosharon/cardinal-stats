root = exports ? this

class root.PlayerModel extends Backbone.Model
    defaults:
        name: 'default name'
        number: '1'
        position: 1
        active: false

    hitStatModel: null
    serveStatModel: null
    digStatModel: null
    srStatModel: null
    blockStatModel: null
    setStatModel: null


    rotate: =>
        if @get('active')
            position = @get('position')
            rotatedPosition = root.rotatedPosition(position)
            @set 'position', rotatedPosition

    getHitData: =>
        history = @hitStatModel.get('history')
        data = _.countBy history, (x) =>
            if x is 'l'
                return 'hit'
            if x is '+'
                return 'kill'
            if x is 'O'
                return 'error'
        data = _.defaults data, {
            hit: 0.0
            kill: 0.0
            error: 0.0
        }
        data.attempt = data.hit + data.kill + data.error
        if data.attempt > 0
            data.hittingPercentage = (data.kill - data.error) / parseFloat(data.attempt)
        else
            data.hittingPercentage = 0

    getSrData: =>
        data = {}
        history = @srStatModel.get('history')
        data.total = _.size history
        sum = _.reduce history,
            (memo, num) ->
                return memo + num
            , 0.0
        if data.total > 0
            data.avg = sum / data.total

        data = _.defaults data, {
            total: 0
            avg: 0
        }
        return data


    addStatModel: (statModel, statType) =>
        if statType == 1 # DIG
            @digStatModel = statModel
        else if statType == 2 # HIT
            @hitStatModel = statModel
        else if statType == 3 # BLOCK
            @blockStatModel = statModel
        else if statType == 4 # SET
            @setStatModel = statModel
        else if statType == 5 # SR
            @srStatModel = statModel
        else if statType == 6 # SERVE
            @serveStatModel = statModel
        else
            console.error 'no stat type', statType

    getStatModel: (statType) =>
        if statType == 1 # DIG
            return @digStatModel
        else if statType == 2 # HIT
            return @hitStatModel
        else if statType == 3 # BLOCK
            return @blockStatModel
        else if statType == 4 # SET
            return @setStatModel
        else if statType == 5 # SR
            return @srStatModel
        else if statType == 6 # SERVE
            return @serveStatModel
        else
            console.error 'no stat statType', statType
