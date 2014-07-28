LiteTracker.Models.Tab = Backbone.Model.extend({  
  parse: function (payload) {
    if (payload.stories) {
      this.stories().set(payload.stories, { parse: true });
      delete payload.stories;
    }
    
    return payload;
  },
  
  project: function () {
    return this.collection.project;
  },
  
  stories: function () {
    this._stories = this._stories ||
                    new LiteTracker.Collections.Stories([], { tab: this });
    return this._stories;
  }
});