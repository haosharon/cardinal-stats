root = exports ? this

class root.TeamModel extends Backbone.Model
    defaults:
        score: 0
        team_name: 'team name'
        serving: false
        opponent: null
        players: null

    increment: =>
        score = @get 'score'
        score += 1
        @set 'score', score

    rotate: =>
        @get('players').forEach (player) =>
            if player.get('active')
                player.rotate()

    activePlayers: =>
        @get('players').where(
            'active': true
            )


