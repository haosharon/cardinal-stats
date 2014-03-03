root = exports ? this

class root.ServeSelectorController
    constructor: (args) ->
        @container = args.container
        @serveModel = new root.SingleStatModel()
        @selectorModel = new root.ServeSelectorModel()

        @buildView()
        @currentController = null

    bindController: (controller) =>
        @currentController = controller

    present: =>
        @serveModel.reset()
        @view.show()

    dismiss: =>
        @view.hide()


    buildView: =>
        @view = new root.ServeSelectorView(
            controller: @
            model: @serveModel
            selectorModel: @selectorModel
            )
        @container.append @view.$el

    addStat: (value, selectorModel) =>
        options = {
            x: selectorModel.get('clickX')
            y: selectorModel.get('clickY')
        }
        @currentController.addServeStat value, options


class root.ServeSelectorView extends Backbone.View
    className: 'serve-selector modal-container'
    initialize: (args) =>
        @controller = args.controller
        @model = args.model
        @selectorModel = args.selectorModel
        @render()
        @initializeModelListeners()

    initializeModelListeners: =>
        @model.on 'progressed', () =>
            @showValue()
        @model.on 'locked', (args) =>
            @flash =>
                @controller.addStat(args.value, @selectorModel)


    initializeTapHandler: =>
        @tapHandler = new root.TapHandler(
            el: @$el.find('.serve-selector-canvas')
            )
        @tapHandler.on 'increment', () =>
            @model.progress()
        @tapHandler.on 'locked', (args) =>
            @model.lock()
        @tapHandler.fastButton.on 'fastClick', @_clicked

    _clicked: (e) =>
        if not @selectorModel.get('hasClicked')
            @selectorModel.set('clickX', e.offsetX)
            @selectorModel.set('clickY', e.offsetY)
            @_ping @selectorModel.get('clickX'), @selectorModel.get('clickY')
        @selectorModel.set('hasClicked', true)


    flash: (callback) =>
        @_addEmphasis()
        setTimeout( =>
            @_removeEmphasis()
            callback()
        , 400)

    _addEmphasis: =>
        @$('.serve-selector-canvas').addClass 'emphasize'

    _removeEmphasis: =>
        @$('.serve-selector-canvas').removeClass 'emphasize'

    showValue: =>
        val = ''
        if @model.get 'active'
            val = @model.get 'value'
        @$('.serve-value').html val

    show: =>
        @$el.find('.modal').addClass('showing')
        @selectorModel.set('hasClicked', false)
        @_clearCanvas()
        @_drawAreaLines()
        @showValue()


    hide: =>
        @$('.modal').removeClass('showing')

    _drawAreaLines: =>
        canvas = @$('.serve-selector-canvas')[0]
        ctx = canvas.getContext('2d')
        ctx.strokeStyle = 'black'
        ctx.lineWidth = 1
        ctx.setLineDash([8,8])
        # draw first vertical line
        ctx.beginPath()
        ctx.moveTo(133.3, 0)
        ctx.lineTo(133.3, 400)
        ctx.stroke()

        # draw second vertical line
        ctx.beginPath()
        ctx.moveTo(266.6, 0)
        ctx.lineTo(266.6, 400)
        ctx.stroke()

        ctx.lineWidth = 4
        ctx.setLineDash([])

        # draw horizontal ten foot line
        ctx.beginPath()
        ctx.moveTo(0, 266.6)
        ctx.lineTo(400, 266.6)
        ctx.stroke()

    _ping: (x, y) =>
        canvas = @$('.serve-selector-canvas')[0]
        ctx = canvas.getContext('2d')
        ctx.strokeStyle = 'red'
        ctx.lineWidth = 4

        radius = 10
        ctx.beginPath()
        ctx.arc(x, y, radius, 0, 2 * Math.PI)
        ctx.stroke()

        offset = 16
        ctx.beginPath()
        ctx.moveTo(x - offset, y)
        ctx.lineTo(x + offset, y)
        ctx.stroke()

        ctx.beginPath()
        ctx.moveTo(x, y - offset)
        ctx.lineTo(x , y + offset)
        ctx.stroke()

    _clearCanvas: =>
        canvas = @$('.serve-selector-canvas')[0]
        ctx = canvas.getContext('2d')
        ctx.clearRect(0, 0, 400, 400)


    render: =>
        template = root.getTemplate 'serve-selector', (template) =>
            @$el.html template
            @_clearCanvas()
            @_drawAreaLines()
            @showValue()
            @initializeTapHandler()
