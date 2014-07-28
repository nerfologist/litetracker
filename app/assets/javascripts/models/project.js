LiteTracker.Models.Project = Backbone.Model.extend({
  urlRoot: '/api/projects',
  
  parse: function (payload) {
    if(payload.tabs) {
      this.tabs().set(payload.tabs, { parse: true })
      delete payload.tabs;
    }
        
    return payload;
  },
  
  tabs: function () {
    this._tabs = this._tabs ||
                 new LiteTracker.Collections.Tabs([], { project: this });
    return this._tabs;
  }
});