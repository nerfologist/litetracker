LiteTracker.Models.Project = Backbone.Model.extend({
  urlRoot: '/api/projects',
  
  parse: function (payload) {
    "use strict";
    if(payload.tabs) {
      this.tabs().set(payload.tabs, { parse: true });
      delete payload.tabs;
    }
        
    return payload;
  },
  
  tabs: function () {
    "use strict";
    this._tabs = this._tabs ||
                 new LiteTracker.Collections.Tabs([], { project: this });
    return this._tabs;
  }
});