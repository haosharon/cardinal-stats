root = exports ? this
class root.MainController
    constructor: (args) ->
        @container = args.container
        @buildTeamModels(args.data)
        @statsModel = @buildStatsModel(args.data)
        @initializeLogger()

        @gridController = new root.StatGridController(
            mainController: @
            container: @container
            statsModel: @statsModel
            logger: @logger
            )
        @dashboardController = new root.DashboardController(
            mainController: @
            container: @container
            statsModel: @statsModel
            logger: @logger
            )
        @serveSelector = new root.ServeSelectorController(
            mainController: @
            container: @container
            statsModel: @statsModel
            logger: @logger
            )
        @subSelector = new root.SubSelectorController(
            mainController: @
            container: @container
            statsModel: @statsModel
            logger: @logger
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
            @focusTeam.get('players').add(playerModel)

        statsModel.setFocusTeam @focusTeam
        statsModel.setOtherTeam @otherTeam

        return statsModel
