window.LiteTracker = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new LiteTracker.Routers.AppRouter({
      $rootEl: $('div#main')
    });
    Backbone.history.start();
  }
};