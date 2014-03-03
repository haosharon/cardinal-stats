root = exports ? this

class root.SubSelectorPlayerView extends Backbone.View
    className: 'sub-selector-player'

    initialize: (args) =>
        @player = args.player
        @controller = args.controller
        @_initializeClickHandler()

    _initializeClickHandler: =>
        @fastButton = new root.FastButton(
            el: @el
            )
        @fastButton.on 'fastClick', @click

    click: =>
        @flash =>
            @controller.selectedSub(@player)

    flash: (callback) =>
        @_addEmphasis()
        setTimeout( =>
            @_removeEmphasis()
            callback()
        , 400)

    render: (odd) =>
        root.getTemplate 'sub-selector-player', (template) =>
            @$el.html template(@player.toJSON())
            if odd
                @$el.addClass('odd')
            else
                @$el.removeClass('odd')

    _removeEmphasis: =>
        @$el.removeClass('emphasize')

    _addEmphasis: =>
        @$el.addClass('emphasize')