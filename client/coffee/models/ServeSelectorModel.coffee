root = exports ? this

class root.ServeSelectorModel extends Backbone.Model
    defaults:
        hasClicked: false
            clickX: 0
            clickY: 0