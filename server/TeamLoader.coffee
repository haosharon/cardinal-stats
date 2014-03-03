
Meteor.methods(
  getConfigurations: ->
    players = [
        {
            number: 16
            name: 'nicole'
            position: 1
            active: true
        },
        {
            number: 14
            name: 'jenny'
            position: 2
            active: true
        },
        {
            number: 13
            name: 'kristine'
            position: 3
            active: true
        },
        {
            number: 15
            name: 'rachel'
            position: 4
            active: true
        },
        {
            number: 9
            name: 'emma'
            position: 5
            active: true
        },
        {
            number: 10
            name: 'tati'
            position: 6
            active: true
        },
        {
            number: 5
            name: 'sharon'
            active: false
        },
        {
            number: 1
            name: 'meryl'
            active: false
        },
        {
            number: 8
            name: 'jess'
            active: false
        },
        {
            number: 2
            name: 'lauren'
            active: false
        }
    ]
    data = {}
    data.players = players

    return JSON.stringify(data)
  )
