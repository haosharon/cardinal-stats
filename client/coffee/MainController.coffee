root = exports ? this

class root.MainController
    constructor: (args) ->
        @container = args.container
        @buildTeamModels()
        @statsModel = @buildStatsModel()
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

    buildTeamModels: =>
        @focusTeam = new root.TeamModel(
            team_name: 'MIT'
            players: new Backbone.Collection()
            )
        @otherTeam = new root.TeamModel(
            team_name: 'other team'
            players: new Backbone.Collection()
            )

        @focusTeam.set 'opponent', @otherTeam
        @otherTeam.set 'opponent', @focusTeam

    buildStatsModel: =>
        players = [
            {
                number: 16
                name: 'nicole'
                position: 1
                active: true
            },
            {
                number: 14
                name: 'jenny'
                position: 2
                active: true
            },
            {
                number: 13
                name: 'kristine'
                position: 3
                active: true
            },
            {
                number: 15
                name: 'rachel'
                position: 4
                active: true
            },
            {
                number: 9
                name: 'emma'
                position: 5
                active: true
            },
            {
                number: 10
                name: 'tati'
                position: 6
                active: true
            },
            {
                number: 5
                name: 'sharon'
                active: false
            },
            {
                number: 1
                name: 'meryl'
                active: false
            },
            {
                number: 8
                name: 'jess'
                active: false
            },
            {
                number: 2
                name: 'lauren'
                active: false
            }
        ]
        statsModel = new root.StatsModel()


        for player in players
            playerModel = new root.PlayerModel(
                player
                )
            @focusTeam.get('players').add(playerModel)

        statsModel.setFocusTeam @focusTeam
        statsModel.setOtherTeam @otherTeam

        return statsModel
