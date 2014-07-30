LiteTracker.Models.Story = Backbone.Model.extend({
  urlRoot: function () {
    "use strict";
    return 'api/projects/' + this.project().get('id') + '/stories';
  },
  
  validate: function (attributes, options) {
    "use strict";
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