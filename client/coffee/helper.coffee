root = exports ? this

root.HandlebarsRegistry = {}

# CONSTANTS

CONSTANTS = {}

statsToTrack = ['DIG', 'HIT', 'BLOCK', 'SET', 'SR', 'SERVE', 'SUB', 'SCORE']
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
        2: ['l', '+', 'O'] # HIT
        3: [1] # SET
        4: [1] # SR
        5: [0, 1, 2, 3] # SERVE

_.extend root,
    C: CONSTANTS

root.statTypeToString = (statType) ->
    return root.C.STAT_KEYS[statType]

root.rotatedPosition = (position) ->
    if position == 1
        return 6
    return position - 1

ROMANS = ['', 'I', 'II', 'III', 'IV', 'V', 'VI']
root.displayPosition = (position) ->
    return ROMANS[position]
