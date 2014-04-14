root = exports ? this
class root.StatResultsController
  constructor: (args) ->
    @mainController = args.mainController
    @container = args.container
    @statsModel = args.statsModel
    @buildView()

  buildView: =>
    @view = new root.StatResultsView(
      controller: @
      statsModel: @statsModel
      )
    @container.append @view.$el

  showResults: =>
    @container.removeClass 'hidden'

class root.StatResultsView extends Backbone.View
  className: 'stat-results'
  initialize: (@args) =>
    @controller = args.controller
    @statsModel = args.statsModel
    @render()
    @listenToStats()

  listenToStats: =>
    # TODO

  render: =>
    @$el.html Template.results(
      team_name: @statsModel.getFocusTeam()?.get('team_name')
      )

