Pomodoros = new Meteor.Collection("pomodoros")

if (typeof(Npm) !== "undefined"){
  var fs = Npm.require('fs');
}


if (Meteor.isClient) {
  // counter starts at 0
  Session.setDefault('counter', 0);

  Template.pomodoro.helpers({
    pomodoros: function () {
      return Pomodoros.find({});
    }
  });

  Template.pomodoro.events({
    'click button': function () {
      Meteor.call("startPomodoro");
    }
  });

  Meteor.subscribe("stats");
  Meteor.subscribe("pomodoros_today");
  Stats = new Meteor.Collection("stats");

  Template.body.helpers({
    scratchCount: function(){
      if (Stats.findOne("scratchCount")){
        return Stats.findOne("scratchCount").count;
      }
    }
  })
}

if (Meteor.isServer) {
  Meteor.publish("stats", function(){
    var _this = this;
    scratchLines(function(lineCount){
      _this.added("stats", "scratchCount", {count: lineCount});
    });
    Meteor.setInterval(function(){
      scratchLines(function(lineCount){
        _this.changed("stats", "scratchCount", {count: lineCount});
      })
    }, 2000);
  });
}

var scratchLines = function(cb){
  fs.readFile("/Users/mike/Dropbox/scratch.txt", "utf-8", function(err, data){
    cb(data.split("\n").length);
  })
}
