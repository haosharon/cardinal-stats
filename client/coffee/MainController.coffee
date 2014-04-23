root = exports ? this
class root.MainController
    constructor: (args) ->
        @statsContainer = args.statsContainer
        @resultsContainer = args.resultsContainer
        @buildTeamModels(args.data)
        @statsModel = @buildStatsModel(args.data)
        @initializeLogger()

        @gridController = new root.StatGridController(
            mainController: @
            container: @statsContainer
            statsModel: @statsModel
            logger: @logger
            )
        @dashboardController = new root.DashboardController(
            mainController: @
            container: @statsContainer
            statsModel: @statsModel
            logger: @logger
            )
        @serveSelector = new root.ServeSelectorController(
            mainController: @
            container: @statsContainer
            statsModel: @statsModel
            logger: @logger
            )
        @subSelector = new root.SubSelectorController(
            mainController: @
            container: @statsContainer
            statsModel: @statsModel
            logger: @logger
            )

        @resultsController = new root.StatResultsController(
            mainController: @
            container: @resultsContainer
            statsModel: @statsModel
            )

    initializeLogger: =>
        @logger = new StatLogger(
            newGame: true
            )

    buildTeamModels: (data) =>
        @focusTeam = new root.TeamModel(
            team_name: data.focusTeam.team_name
            players: new Backbone.Collection()
            )
        @otherTeam = new root.TeamModel(
            team_name: data.otherTeam.team_name
            players: new Backbone.Collection()
            )

        @focusTeam.set 'opponent', @otherTeam
        @otherTeam.set 'opponent', @focusTeam

    buildStatsModel: (data) =>
        statsModel = new root.StatsModel()
        for player in data.focusTeam.players
            playerModel = new root.PlayerModel(
                player
                )
            for statType in [1..6]
                statModel = new root.SingleStatModel(
                    'progression': root.C.STAT_PROGRESSION[statType]
                    )
                playerModel.addStatModel(statModel, statType)
            @focusTeam.get('players').add(playerModel)

        statsModel.setFocusTeam @focusTeam
        statsModel.setOtherTeam @otherTeam

        return statsModel

    goToResults: =>
        # hide this some how
        @statsContainer.addClass 'hidden'
        @resultsController.showResults()

    goToGrid: =>
        @statsContainer.removeClass 'hidden'
