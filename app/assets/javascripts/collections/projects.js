(function () {
  'use strict';

  LiteTracker.Collections.Projects = Backbone.Collection.extend({
    model: LiteTracker.Models.Project,
    url: '/api/projects',

    comparator: 'title',

    getOrFetch: function (id) {
      var project = this.get(id);

      if (!project) {
        var that = this;
        project = new LiteTracker.Models.Project({
          id: id
        });
        project.fetch({
          success: function () {
            that.add(project);
          }
        });
      }

      return project;
    }
  });

  LiteTracker.Collections.projects = new LiteTracker.Collections.Projects();
}());
