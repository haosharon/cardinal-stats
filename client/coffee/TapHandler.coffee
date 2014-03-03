root = exports ? this

class root.TapHandler extends Backbone.View
    initialize: (args) =>
        @fastButton = new root.FastButton(
            el: @el
            )
        @fastButton.on 'fastClick', @fastClick
        @delay = 2000

    fastClick: (e) =>
        # typical click: increase value
        @trigger 'increment'

        # after certain time, lock value in
        clearTimeout @timeout
        @timeout = setTimeout =>
            @trigger 'locked'
        , @delay
