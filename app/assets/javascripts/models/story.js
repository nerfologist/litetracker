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
    "use strict";
    return this.collection.tab;
  },
  
  project: function () {
    "use strict";
    return this.tab().project();
  },
  
  start: function () {
    "use strict";
    this.project().requestStateChange(this, 'started');
  },
  
  accept: function () {
    "use strict";
    this.project().requestStateChange(this, 'accepted');
  }
});