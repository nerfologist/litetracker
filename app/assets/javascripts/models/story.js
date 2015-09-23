(function () {
  'use strict';

  LiteTracker.Models.Story = Backbone.Model.extend({
    urlRoot: function () {
      return this.project.url() + '/stories';
    },

    validate: function (attributes, options) {
      if (attributes.ord < 0) {
        return 'ord cannot be less than 0';
      }
      if (attributes.title === '') {
        return 'title cannot be blank';
      }
    },

    tab: function () {
      return this.collection.tab;
    },

    project: function () {
      return this.tab().project();
    },

    start: function () {
      this.project().requestStateChange(this, 'started');
    },

    accept: function () {
      this.project().requestStateChange(this, 'accepted');
    }
  });
}());
