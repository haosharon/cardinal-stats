root = exports ? this
class root.DashboardController
    constructor: (args) ->
        @container = args.container
        @statsModel = args.statsModel
        @buildView()

    buildView: =>
        @view = new root.DashboardView(
            statsModel: @statsModel
            )
        @container.append @view.$el

class root.DashboardView extends Backbone.View
    className: 'dashboard'
    initialize: (args) =>
        # todo
        @statsModel = args.statsModel
        # for now, say focus is on top
        @focusTeam = new root.TeamView(
            top: true
            model: @statsModel.getFocusTeam()
            )
        @otherTeam = new root.TeamView(
            top: false
            model: @statsModel.getOtherTeam()
            )

        @render()


    render: =>
        @$el.html Template.dashboard()
        container = @$el.find('.score-container')
        container.append @focusTeam.el
        container.append @otherTeam.el



