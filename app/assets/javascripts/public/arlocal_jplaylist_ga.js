Arlocal.jPlayer_ga = {

  _env: {
    development: {
      onReady: function() {
        var reporter = Arlocal.jPlayer_ga.development.reporter_to_console;
        Arlocal.jPlayer_ga._listeners.bind(reporter);
        return true;
      },
      reporter_to_console: function(eventAction, sourceUrl, time) {
        console.log(eventAction, sourceUrl, time);
        return true;
      }
    },
    production: {
      onReady: function() {
        var reporter = Arlocal.jPlayer_ga.production.reporter_to_google_analytics;
        Arlocal.jPlayer_ga._listeners.bind(reporter);
        return true;
      },
      reporter_to_google_analytics: function(eventAction, sourceUrl, time) {
        ga('send', {
          hitType: 'event',
          eventCategory: 'Audio',
          eventAction: eventAction,
          eventLabel: sourceUrl,
          eventValue: time
        });
        return true;
      }
    }
  },
  
  _listeners: {
    bind: function(reporter) {
      $("#jquery_jplayer_1").bind($.jPlayer.event.play, function(event) { Arlocal.jPlayer_ga.play(event, reporter) });
      $("#jquery_jplayer_1").bind($.jPlayer.event.seeking, function(event) { Arlocal.jPlayer_ga.seeking(event, reporter) });
      $("#jquery_jplayer_1").bind($.jPlayer.event.seeked, function(event) { Arlocal.jPlayer_ga.seeked(event, reporter) });
      $("#jquery_jplayer_1").bind($.jPlayer.event.ended, function(event) { Arlocal.jPlayer_ga.ended(event, reporter) });
      return true;
    }
  },

  ended: function(event, reporter) {
    var time = 100;
    var src = event.jPlayer.status.src;
    reporter("ended", src, time);
    return true;
  },
  
  pause: function(event, reporter) {
    var time = Math.round(event.jPlayer.status.currentPercentAbsolute);
    var src = event.jPlayer.status.src;
    if (time < 100) {
      reporter("pause", src, time);
    }
    return true;
  },
  
  play: function(event, reporter) {
    var time = Math.round(event.jPlayer.status.currentPercentAbsolute);
    var src = event.jPlayer.status.src;
    if (time == 0) {
      reporter("play", src, time);
    } else {
      reporter("resume", src, time);
    }
    return true;
  },
  
  seeked: function(event, reporter) {
    var time = Math.round(event.jPlayer.status.currentPercentAbsolute);
    var src = event.jPlayer.status.src;
    if (time > 0) {
      reporter("seek_to", src, time);
    } else {
      reporter("stop", src, time);
    }
    return true;
  },
  
  seeking: function(event, reporter) {
    var time = Math.round(event.jPlayer.status.currentPercentAbsolute);
    var src = event.jPlayer.status.src;
    reporter("seek_from", src, time);
    return true;
  }

};
