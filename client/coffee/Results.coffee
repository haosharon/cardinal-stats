root = exports ? this
class root.StatResultsController
    constructor: (args) ->
        @mainController = args.mainController
        @container = args.container
        @statsModel = args.statsModel
        @buildView()

    buildView: =>
        @view = new root.StatResultsView(
            controller: @
            statsModel: @statsModel
            )
        @container.append @view.$el

    showResults: =>
        @container.removeClass 'hidden'
        @view.render()

    hideResults: =>
        @container.addClass 'hidden'
        @mainController.goToGrid()

class root.StatResultsView extends Backbone.View
    className: 'stat-results'
    initialize: (@args) =>
        @controller = args.controller
        @statsModel = args.statsModel
        @resultsNavBack = null

    getData: =>
        data = {}
        team = @statsModel.getFocusTeam()
        data.team_name = team.get('team_name')
        return data

    render: =>
        @$el.html Template.results(
            @getData()
            )
        @resultsNavBack = new root.FastButton(
            el: @$('.results-nav-back')
            )
        @resultsNavBack.on 'fastClick', =>
            @controller.hideResults()

        team = @statsModel.getFocusTeam()
        team.get('players').forEach (player) =>
            playerView = new root.SinglePLayerResultView(
                controller: @controller
                playerModel: player
                )
            playerView.render()
            @$('.results-summary').append(playerView.$el)

class root.SinglePLayerResultView extends Backbone.View
    className: 'player-results'
    initialize: (@args) =>
        @controller = args.controller
        @playerModel = args.playerModel

    render: =>
        @$el.html Template.playerResults(
            @playerModel.getResultData()
            )