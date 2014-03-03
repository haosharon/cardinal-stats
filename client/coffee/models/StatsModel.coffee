root = exports ? this

class root.StatsModel extends Backbone.Model
    defaults:
        # this stats model is from the point of view of the serving team
        first_serve: true
        serving: true # is the focused team serving?
        teams: [null, null]

    setFocusTeam:(teamModel) =>
        @get('teams')[0] = teamModel
        @watchTeam teamModel

    setOtherTeam:(teamModel) =>
        @get('teams')[1] = teamModel
        @watchTeam teamModel

    watchTeam: (teamModel) =>
        teamModel.on 'change:score', =>
            # find out if that team should rotate
            if teamModel.get('serving')
                # don't need to rotate
            else
                # change serving
                teamModel.set 'serving', true
                opponent = teamModel.get('opponent')
                opponent.set 'serving', false
                teamModel.rotate()

    getFocusTeam: =>
        # the focus team is the first team
        return @get('teams')[0]

    getOtherTeam: =>
        return @get('teams')[1]
