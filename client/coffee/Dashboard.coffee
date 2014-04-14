root = exports ? this
class root.DashboardController
    constructor: (args) ->
        @container = args.container
        @statsModel = args.statsModel
        @logger = args.logger
        @buildView()

    buildView: =>
        @view = new root.DashboardView(
            statsModel: @statsModel
            logger: @logger
            )
        @container.append @view.$el

class root.DashboardView extends Backbone.View
    className: 'dashboard'
    initialize: (args) =>
        # todo
        @logger = args.logger
        @statsModel = args.statsModel
        # for now, say focus is on top
        @focusTeam = new root.TeamView(
            top: true
            model: @statsModel.getFocusTeam()
            logger: @logger
            )
        @otherTeam = new root.TeamView(
            top: false
            model: @statsModel.getOtherTeam()
            logger: @logger
            )

        @render()


    render: =>
        @$el.html Template.dashboard()
        container = @$el.find('.score-container')
        container.append @focusTeam.el
        container.append @otherTeam.el



