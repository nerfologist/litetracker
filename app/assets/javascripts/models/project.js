LiteTracker.Models.Project = Backbone.Model.extend({
  urlRoot: '/api/projects',
  
  parse: function (payload) {
    if(payload.tabs) {
      this.tabs().set(payload.tabs, { parse: true })
      delete payload.tabs;
    }
    
    if(payload.stories) {
      this.stories().set(payload.stories, { parse: true })
      delete payload.stories;
    }
    
    return payload;
  },
  
  tabs: function () {
    this._tabs = this._tabs ||
                 new LiteTracker.Collections.Tabs([], { project: this });
    return this._tabs;
  },
  
  stories: function () {
    this._stories = this._stories ||
                    new LiteTracker.Collections.Stories([], { project: this });
    return this._stories;
  }
});