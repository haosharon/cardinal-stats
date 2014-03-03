root = exports ? this

class root.TeamView extends Backbone.View
    className: 'team'
    initialize: (args) =>
        @model = args.model
        @top = args.top
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
