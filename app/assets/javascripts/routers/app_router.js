LiteTracker.Routers.AppRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },
  
  routes: {
    ''              : 'projectsIndex',
    'projects/:id'  : 'showProject'
  },
  
  projectsIndex: function () {
    var view = new LiteTracker.Views.ProjectsIndex({
      collection: LiteTracker.Collections.projects
    });
    
    LiteTracker.Collections.projects.fetch();
    
    this._swapView(view);
  },
  
  showProject: function (id) {
    var project = LiteTracker.Collections.projects.getOrFetch(id);
    // refresh project anyway
    project.fetch();
    
    var view = new LiteTracker.Views.ProjectShow({
      model: project
    });
    
    this._swapView(view);
  },
  
  _swapView: function (newView) {
    this.currentView && this.currentView.remove();
    
    this.$rootEl.html(newView.render().$el)
    this.currentView = newView;
  }
});