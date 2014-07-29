window.LiteTracker = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    "use strict";
    new LiteTracker.Routers.AppRouter({
      $rootEl: $('div#main')
    });
    Backbone.history.start();
  }
};