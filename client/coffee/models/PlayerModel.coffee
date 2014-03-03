root = exports ? this

class root.PlayerModel extends Backbone.Model
    name: 'default name'
    number: '1'
    position: 1
    active: false

    rotate: =>
        if @get('active')
            position = @get('position')
            rotatedPosition = root.rotatedPosition(position)
            @set 'position', rotatedPosition
