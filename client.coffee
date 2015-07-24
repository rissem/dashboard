if Meteor.isClient
  activePomodoro = ->
    return Pomodoros.findOne({start: {$gt: Session.get("now") - 25*60*1000}})

  Template.pomodoro.helpers 
    dayCount: ->
      Pomodoros.find({start: {$gt: 0}}).count()

    times: ->
      results = []
      for hour in [8..19]
        for minute in [0..60] by 5
          d = new Date()
          d.setHours(hour)
          d.setMinutes(minute)
          results.push(d)
      results

  Template.activePomodoro.helpers
    active: ->
      activePomodoro()

    timeRemaining: ->
      pomodoro = activePomodoro()
      return unless pomodoro
      totalSecondsRemaining = (25*60*1000 - (Session.get("now") - pomodoro.start))/1000
      # console.log "total seconds remaining", totalSecondsRemaining
      minutesRemaining = Math.floor(totalSecondsRemaining/60)
      secondsRemaining = Math.floor(totalSecondsRemaining % 60) #TODO pad seconds
      document.title = "#{minutesRemaining}:#{secondsRemaining}"
      "#{minutesRemaining}:#{secondsRemaining}"

  Meteor.setInterval ->
    Session.set "now", Date.now()
  , 500
