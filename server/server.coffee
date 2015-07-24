Meteor.publish "pomodoros_today", ->
  #TODO how can we ensure this publication changes in the future?
  #have to set a timeout?
  d = new Date
  d.setHours(0,0,0,0)
  Pomodoros.find({start: {$gt: d.getTime()}})
