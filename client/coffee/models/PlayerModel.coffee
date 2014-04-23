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

    getResultData: =>
        data = {
            name: @get('name')
            number: @get('number')
        }
        _.extend data,
            @getHitData(),
            @getSrData(),
            @getSetData(),
            @getServeData(),
            @getBlockData()
            @getDigData()

        return data


    getHitData: =>
        history = @hitStatModel.get('history')
        data = _.countBy history, (x) =>
            if x is 'l'
                return 'hitRegular'
            if x is '+'
                return 'hitKill'
            if x is 'O'
                return 'hitError'
        data = _.defaults data, {
            hitRegular: 0.0
            hitKill: 0.0
            hitError: 0.0
        }
        data.hitTotal = data.hitRegular + data.hitKill + data.hitError
        if data.hitTotal > 0
            hitPercent = (data.hitKill - data.hitError) / parseFloat(data.hitTotal)
            data.hitPercent = hitPercent.toString().slice(0,5)
        else
            data.hitPercent = '0'
        return data

    getSrData: =>
        data = {}
        history = @srStatModel.get('history')
        data.srTotal = _.size history
        sum = _.reduce history,
            (memo, num) ->
                return memo + num
            , 0.0
        if data.srTotal > 0
            srAvg = sum / data.srTotal
            data.srAvg = srAvg.toString().slice(0, 5)

        data = _.defaults data, {
            srTotal: 0
            srAvg: 0
        }
        return data

    getSetData: =>
        return {
            setTotal: _.size(@setStatModel.get('history'))
        }

    getServeData: =>
        data = {}
        history = @serveStatModel.get('history')
        data = _.countBy history, (x) =>
            if x == 0
                return 'serveError'
            else if x == 3
                return 'serveAce'
            else
                return "serve#{x}"
        data = _.defaults data, {
            serveError: 0
            serveAce: 0
            serveTotal: _.size(history)
        }

        return data

    getBlockData: =>
        return {
            blockTotal: _.size(@blockStatModel.get('history'))
        }

    getDigData: =>
        return {
            digTotal: _.size(@digStatModel.get('history'))
        }

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
