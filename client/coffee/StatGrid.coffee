root = exports ? this
class root.StatGridController
    constructor: (args) ->
        @mainController = args.mainController
        @container = args.container
        @statsModel = args.statsModel
        @team = @statsModel.getFocusTeam()
        @logger = args.logger

        @buildRowControllers()
        @buildView()


    buildRowControllers: =>
        @rowControllers = []
        # positioned controllers keeps the ordering
        @positionedControllers = []
        row = 0
        while row <= 5
            rowModel = new root.StatRowModel(
                row: row
                )
            rowController = new root.StatRowController(
                mainController: @mainController
                model: rowModel
                gridController: this
                )

            @rowControllers.push rowController
            @positionedControllers.push rowController
            row += 1

        # assign players to each row
        @team.activePlayers().forEach (player) =>
            position = player.get 'position'
            rowController = @positionedControllers[position - 1]
            rowController.setPlayer player

        _.each @rowControllers, (rowController) =>
            rowController.view.listenToChanges()
            rowController.view.render()

    buildView: =>
        @view = new root.StatGridView(
            statsModel: @statsModel
            rowControllers: @positionedControllers
            )

        @container.append(@view.$el)

    logStat: (stat) =>
        # stat is a SingleStatValueModel type
        @logger.logStat stat

class root.StatGridView extends Backbone.View
    className: 'stats-grid'


    initialize: (args) =>
        @statsModel = args.statsModel
        @rowControllers = args.rowControllers
        @render()


    render: =>
        @$el.html(Template.statRowHeader())
        _.each @rowControllers, (rowController) =>
            @$el.append rowController.view.el
        @$el.find('.stat-row').last().addClass('last')


