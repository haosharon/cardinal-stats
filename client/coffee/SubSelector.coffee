root = exports ? this

class root.SubSelectorController
    constructor: (args) ->
        @container = args.container
        @statsModel = args.statsModel
        @buildView()
        @currentController = null

    bindRowModel: (rowModel) =>
        @rowModel = rowModel

    bindController: (controller) =>
        @currentController = controller

    buildView: =>
        @view = new root.SubSelectorView(
            controller: @
            team: @statsModel.getFocusTeam()
            )
        @container.append @view.el

    present: =>
        @view.show()

    dismiss: =>
        @view.hide()

    selectedSub: (newPlayer) =>
        # remove current player
        previousPlayer = @rowModel.get('player')
        position = previousPlayer.get('position')
        previousPlayer.set('active', false)
        # active new player
        newPlayer.set('active', true)
        newPlayer.set('position', position)

        # set current player
        @rowModel.set('player', newPlayer)
        @statsModel.getFocusTeam().trigger('change:activePlayers')
        @currentController.makeSub newPlayer, previousPlayer

class root.SubSelectorView extends Backbone.View
    className: 'sub-selector cs-modal-container'
    initialize: (args) =>
        @controller = args.controller
        @team = args.team
        @playerViews = {}
        @_createSubViews()
        @render()

        @team.on 'change:activePlayers', =>
            isShowing = @$('.cs-modal').hasClass('showing')
            @playerViews = {}
            @_createSubViews()
            @render()

    render: =>
        @$el.html(Template.subSelector())
        @_renderSubs()

    _createSubViews: =>
        @team.get('players').forEach (player) =>
            if not player.get('active')
                playerView = new root.SubSelectorPlayerView(
                    player: player
                    controller: @controller
                    )
                @playerViews[player.get('number')] = playerView

    _renderSubs: =>
        @$('.sub-list').empty()
        odd = true
        _.each @playerViews, (playerView, number) =>
            @$('.sub-list').append(playerView.$el)
            playerView.render(odd)
            odd = not odd


    show: =>
        @$('.cs-modal').addClass('showing')

    hide: =>
        @$('.cs-modal').removeClass('showing')