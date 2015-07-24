Meteor.methods
  startPomodoro: ->
    Pomodoros.insert({
      start: Date.now()
    })
    # should check that no other pomodoros are active
    # should check that at leat a 5 minute break has been taken
