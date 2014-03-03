root = exports ? this

class root.FastButton extends Backbone.View

    events: =>
        mobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)

        startevent = if mobile then 'touchstart' else 'mousedown'
        endevent = if mobile then 'touchend' else 'mouseup'

        events = {}
        events[startevent] = 'start'
        events[endevent] = 'end'
        return events

    start: (e) =>
        # TODO have a state
        # so we can prevent ghost clicks later

    end: (e) =>
        # TODO check if this is a ghost click
        @trigger 'fastClick', e

