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

class root.StatResultsView extends Backbone.View
    className: 'stat-results'
    initialize: (@args) =>
        @controller = args.controller
        @statsModel = args.statsModel

    getData: =>
        data = {}
        team = @statsModel.getFocusTeam()
        data.team_name = team.get('team_name')
        team.get('players').forEach (player) =>
            totalHits = player.getHitData()
            console.log 'totalHits'
            console.log totalHits
            srData = player.getSrData()
            console.log 'sr data'
            console.log srData

        return data

    render: =>
        @$el.html Template.results(
            @getData()
            )

