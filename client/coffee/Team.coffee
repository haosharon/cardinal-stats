root = exports ? this

class root.TeamView extends Backbone.View
    className: 'team'
    initialize: (args) =>
        @model = args.model
        @top = args.top
        @logger = args.logger
        @render()
        @initializeClickable()
        @watchScore()

    initializeClickable: =>
        @fastButton = new root.FastButton(
            el: @$el
            )
        @fastButton.on 'fastClick', =>
            @model.increment()

    watchScore: =>
        @model.on 'change:score', =>
            score = @model.get 'score'
            @$el.find('.score').html score
            stat = new root.SingleStatValueModel(
                team: @model.get('team_name')
                statType: 8
                value: @model.get('score')
                )
            @logger.logStat(stat)

    render: =>
        @$el.html Template.team(
            top: @top
            score: @model.get 'score'
            name: @model.get 'team_name'
            )
        if @top
            @$el.addClass('top')
        else
            @$el.addClass('bottom')
