root = exports ? this

class root.SingleStatModel extends Backbone.Model
    defaults:
        progression: [0, 1, 2, 3]

    initialize: =>
        @set 'history', []
        @reset()

    progress: =>
        if @get 'active'
            @_increaseIndex()
        else
            @index = 0
            @set 'active', true
        newVal = @get('progression')[@index]
        @set 'value', newVal
        @trigger 'progressed'

    lock: =>
        value = @get 'value'
        @get('history').push value
        @reset()
        @trigger 'locked', {value: value}

    reset: =>
        @set 'active', false
        @set 'value', '-1'

    singularHistoryValue: =>
        return @get('history').length

    _increaseIndex: =>
        @index = (@index + 1) % @get('progression').length
