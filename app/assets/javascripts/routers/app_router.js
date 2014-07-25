LiteTracker.Routers.AppRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },
  
  routes: {
    '' : 'projectsIndex'
  },
  
  projectsIndex: function () {
    var view = new LiteTracker.Views.ProjectsIndex({
      collection: LiteTracker.Collections.projects
    });
    
    this._swapView(view);
  },
  
  _swapView: function (newView) {
    this.currentView && this.currentView.remove();
    
    this.$rootEl.html(newView.render().$el)
    this.currentView = newView;
  }
});