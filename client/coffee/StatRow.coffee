root = exports ? this

class root.StatRowController
    constructor: (args) ->
        @mainController = args.mainController
        @gridController = args.gridController
        @model = args.model
        @view = new root.StatRowView(
            model: args.model
            controller: this
            )

    serve: =>
        serveSelector = @mainController.serveSelector
        serveSelector.bindController this
        serveSelector.present()

    sub: =>
        subSelector = @mainController.subSelector
        subSelector.bindRowModel @model
        subSelector.bindController this
        subSelector.present()

    setPlayer: (player) =>
        @model.set 'player', player

    getPlayer: =>
        return @model.get 'player'

    makeSub: (newPlayer, previousPlayer) =>
        data = _.extend {}, {
            'player': newPlayer
            'statType': 7 # HACK
            'options': {
                'previousPlayer': previousPlayer
                'position': newPlayer.get('position')
            }
        }
        stat = new root.SingleStatValueModel(data)
        @gridController.logStat stat
        @mainController.subSelector.dismiss()


    addServeStat: (value, options) =>
        # stat = new root.SingleStatValueModel(
        #         player: @model.get 'player'
        #         statType: 6 # HACK
        #         value: value
        #     )
        data = _.extend {}, {
            'value': value
            'player': @model.get 'player'
            'statType': 6 # HACK
            'options': options
        }
        stat = new root.SingleStatValueModel(data)
        @gridController.logStat stat
        # @addStat @model.get('player'), 6, value
        # dismiss serve
        @mainController.serveSelector.dismiss()
        # serveSelector.dismiss()

    addStat: (player, statType, value) =>
        stat = new root.SingleStatValueModel(
            player: player
            statType: statType
            value: value
            )
        @gridController.logStat stat



class root.StatRowView extends Backbone.View
    className: 'stat-row'
    initialize: (args) =>
        @model = args.model
        @controller = args.controller
        @render()

    listenToChanges: =>
        player = @model.get 'player'
        @model.on 'change:player', @render
        player.on 'change:position', =>
            @$el.find('.position').html(root.displayPosition(player.get('position')))


    render: =>
        template = root.getTemplate 'stat-row', (template) =>
            player = @model.get 'player'
            @$el.html template()
            playerView = new root.PlayerCellView(
                controller: @controller
                player: @model.get('player')
                el: @$el.find('.player')
                )
            inputs = @$el.find('.stat-inp')
            _.each inputs, (input, index) =>
                statType = root.C.ORDER[index]
                statModel = new root.SingleStatModel(
                    'progression': root.C.STAT_PROGRESSION[statType]
                    )
                cellView = new root.StatCellView(
                    model: statModel
                    controller: @controller
                    el: input
                    player: player
                    statType: statType
                    )
            @listenToChanges()

