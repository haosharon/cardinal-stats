root = exports ? this

class root.StatCellView extends Backbone.View
    className: 'stat-cell-view'
    initialize: (args) =>
        @stat_info = args.stat_info
        @el = args.el
        @model = args.model
        @controller = args.controller
        @player = args.player
        @statType = args.statType
        @initializeModelListeners()
        @initializeTapHandler()
        @render()

    initializeModelListeners: =>
        @model.on 'progressed', () =>
            @showValue()
            @showHistory()

        @model.on 'locked', (args) =>
            @showValue()
            @showHistory()
            @flash()
            @controller.addStat(@player, @statType, args.value)

        @model.on 'change:active', =>
            cell = @$el.find('.stat-inp-cell')
            if @model.get 'active'
                cell.addClass 'active'
            else
                cell.removeClass 'active'

    flash: =>
        @_addEmphasis()
        setTimeout( =>
            @_removeEmphasis()
        , 400)

    _addEmphasis: =>
        @$el.find('.stat-inp-cell').addClass 'emphasize'
    _removeEmphasis: =>
        @$el.find('.stat-inp-cell').removeClass 'emphasize'

    initializeTapHandler: =>
        @tapHandler = new root.TapHandler(
            el: @el
            )

        @tapHandler.on 'increment', () =>
            @model.progress()
        @tapHandler.on 'locked', () =>
            @model.lock()

    showValue: =>
        val = ''
        if @model.get 'active'
            val = @model.get 'value'
        @$el.find('.stat-inp-cell .value').html val


    showHistory: =>
        @$el.find('.stat-inp-cell .summary').html @model.singularHistoryValue()

    render: =>
        @$el.html(Template.statCell(
            name: @player.get('name')
            statType: root.statTypeToString(@statType)
            ))
        @$el.find('.stat-inp-cell').addClass root.statTypeToString(@statType)
        @showValue()
        @showHistory()




