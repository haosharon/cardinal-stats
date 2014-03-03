root = exports ? this

class root.StatRowModel extends Backbone.Model
    # -------
    #| 1 6 5 |
    #| 2 3 4 |
    # -------
    # 1 is the first server, 6 is the last
    player: null
    row: 0
