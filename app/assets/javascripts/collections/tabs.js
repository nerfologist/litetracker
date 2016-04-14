(function () {
  'use strict';

  LiteTracker.Collections.Tabs = Backbone.Collection.extend({
    model: LiteTracker.Models.Tab,

    url: function () {
      return 'api/projects/' + this.project.get('id') + '/tabs';
    },

    initialize: function (models, options) {
      this.project = options.project;
    },

    comparator: 'ord'
  });

}());
