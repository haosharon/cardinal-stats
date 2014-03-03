root = exports ? this

class root.PlayerCellView extends Backbone.View
    initialize: (args) =>
        @controller = args.controller
        @player = args.player
        @render()

    initializeFastButtons: =>
        @serveButton = new root.FastButton(
            el: @$el.find('.serve')
            )
        @serveButton.on 'fastClick', @controller.serve

        @subButton = new root.FastButton(
            el: @$el.find('.player-info')
            )
        @subButton.on 'fastClick', @controller.sub

    render: =>
        @$el.html Template.playerCell(
            name: @player.get 'name'
            number: @player.get 'number'
            position: root.displayPosition @player.get('position')
            )
        @initializeFastButtons()
