root = exports ? this

class root.SingleStatValueModel extends Backbone.Model
    # needs player, stat type, value, timestamp
    defaults:
        comments: ''
        player: null
        statType: 0
        value: -1
        timestamp: 0
        options: {}

    playerNumber: =>
        player = @get 'player'
        return player.get 'number'

    statTypeString: =>
        statType = @get 'statType'
        return root.C.STAT_KEYS[statType]