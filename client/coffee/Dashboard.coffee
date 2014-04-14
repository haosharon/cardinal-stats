root = exports ? this
class root.DashboardController
    constructor: (args) ->
        @mainController = args.mainController
        @container = args.container
        @statsModel = args.statsModel
        @logger = args.logger
        @buildView()

    buildView: =>
        @view = new root.DashboardView(
            statsModel: @statsModel
            logger: @logger
            controller: @
            )
        @container.append @view.$el

    goToResults: =>
        @mainController.goToResults()

class root.DashboardView extends Backbone.View
    className: 'dashboard'
    initialize: (args) =>
        # todo
        @logger = args.logger
        @statsModel = args.statsModel
        @controller = args.controller
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
        @resultsNavButton = new root.FastButton(
            el: @$('.results-nav')
            )
        @resultsNavButton.on 'fastClick', =>
            @controller.goToResults()


    render: =>
        @$el.html Template.dashboard()
        container = @$el.find('.score-container')
        container.append @focusTeam.el
        container.append @otherTeam.el



