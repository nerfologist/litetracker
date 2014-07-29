LiteTracker.Collections.Tabs = Backbone.Collection.extend({
  model: LiteTracker.Models.Tab,
  
  url: function() {
    "use strict";
    return 'api/projects/' + this.project.get('id') + '/tabs';
  },
  
  initialize: function (models, options) {
    "use strict";
    this.project = options.project;
  },
  
  comparator: 'ord'
});