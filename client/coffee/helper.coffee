root = exports ? this

root.HandlebarsRegistry = {}

# CONSTANTS

CONSTANTS = {}

statsToTrack = ['DIG', 'HIT', 'BLOCK', 'SET', 'SR']
statKeys = {}
order = []
_.each statsToTrack, (val, index) ->
    magicNumber = index + 1 # start at 1 so we aren't confused by undefined errors
    CONSTANTS[val] = magicNumber
    statKeys[magicNumber] = val
    order.push magicNumber # for now, keep this given order

_.extend CONSTANTS,
    ORDER: order
    STAT_KEYS: statKeys
    STAT_PROGRESSION:
        1: [0, 1, 2, 3] # this is a hack. it should be CONSTANTS.DIG but coffee is yelling at me :(
        2:['l', '+', 'O']
        3: [1]
        4: [1]
        5: [0, 1, 2, 3]

_.extend root,
    C: CONSTANTS

root.statTypeToString = (statType) ->
    return root.C.STAT_KEYS[statType]

root.getTemplate = (file, callback) ->
    console.log 'root get template'
    console.log 'todo fix this!'
    # if _.has root.HandlebarsRegistry, file
    #     callback root.HandlebarsRegistry[file]
    # $.ajax
    #     url: "templates/#{file}.handlebars"
    #     cache: true
    #     success: (data) ->
    #         template = Handlebars.compile data
    #         _.extend root.HandlebarsRegistry,
    #             file: template
    #         callback template


root.rotatedPosition = (position) ->
    if position == 1
        return 6
    return position - 1

ROMANS = ['', 'I', 'II', 'III', 'IV', 'V', 'VI']
root.displayPosition = (position) ->
    return ROMANS[position]