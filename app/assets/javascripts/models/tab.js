LiteTracker.Models.Tab = Backbone.Model.extend({  
  parse: function (payload) {
    "use strict";
    if (payload.stories) {
      this.stories().set(payload.stories, { parse: true });
      delete payload.stories;
    }
    
    return payload;
  },
  
  project: function () {
    "use strict";
    return this.collection.project;
  },
  
  stories: function () {
    "use strict";
    this._stories = this._stories ||
                    new LiteTracker.Collections.Stories([], { tab: this });
    return this._stories;
  }
});