LiteTracker.Routers.AppRouter = Backbone.Router.extend({
  initialize: function (options) {
    "use strict";
    this.$rootEl = options.$rootEl;
  },
  
  routes: {
    ''              : 'projectsIndex',
    'projects/:id'  : 'showProject'
  },
  
  projectsIndex: function () {
    "use strict";
    var view = new LiteTracker.Views.ProjectsIndex({
      collection: LiteTracker.Collections.projects
    });
    
    LiteTracker.Collections.projects.fetch();
    
    this._swapView(view);
  },
  
  showProject: function (id) {
    "use strict";
    var project = LiteTracker.Collections.projects.getOrFetch(id);
    // refresh project anyway
    project.fetch();
    
    var view = new LiteTracker.Views.ProjectShow({
      model: project
    });
    
    this._swapView(view);
  },
  
  _swapView: function (newView) {
    "use strict";
    if (this.currentView) {
      this.currentView.remove();
    }
    
    this.$rootEl.html(newView.render().$el);    
    this.currentView = newView;
  }
});