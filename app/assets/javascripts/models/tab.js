LiteTracker.Models.Tab = Backbone.Model.extend({
  initialize: function (options) {
    this.project = options.project;
  },
  
  parse: function (payload) {
    if (payload.stories) {
      this.stories().set(payload.stories, { parse: true });
      delete payload.stories;
    }
    
    return payload;
  },
  
  stories: function () {
    this._stories = this._stories ||
                    new LiteTracker.Collections.Stories([], { project: this.project });
    return this._stories;
  }
});