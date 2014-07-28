LiteTracker.Models.Story = Backbone.Model.extend({
  urlRoot: function () {
    return '/api/projects/' + this.project.get('id') + '/stories';
  },
  
  initialize: function (options) {
    this.project = options.project
  }
});