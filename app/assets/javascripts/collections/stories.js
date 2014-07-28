LiteTracker.Collections.Stories = Backbone.Collection.extend({
  model: LiteTracker.Models.Story,
  
  url: function () {
    return '/api/projects/' + this.project.get('id') + '/stories';
  },
  
  initialize: function (options) {
    this.project = options.project;
  },
  
  comparator: 'ord'
});