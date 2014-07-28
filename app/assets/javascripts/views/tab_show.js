LiteTracker.Views.TabShow = Backbone.CompositeView.extend({
  template: JST['tab/show'],
  
  attributes: function () {
    return {
      'class'               : 'col-xs-3 tab-column' +
                              (this.model.get('visible') ? '' : ' hidden'),
      'id'                  : 'tab-column-' + this.model.escape('name'),
      'data-tab-id'         : this.model.get('id'),
      'data-target-nav-btn' : '#nav-visible-' + this.model.escape('name')
    }
  },
  
  initialize: function () {
    var view = this;
    
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.stories(), 'add', this.addStory);
    this.listenTo(this.model.stories(), 'remove', this.removeStory);
    
    this.model.stories().each(function (story) {
      view.addStory(story);
    });
  },
  
  render: function () {
    var renderedContent = this.template({ tab: this.model });
    this.$el.html(renderedContent);
    
    this.attachSubviews();
    
    return this;
  },
  
  addStory: function (story) {
    var storyView = new LiteTracker.Views.StoryShow({ model: story });
    this.addSubview('.stories-column', storyView);
  },
  
  removeStory: function (story) {
    var subview = _.find(
      this.subviews('.stories-column'), function (subview) {
        return subview.model === story;
      }
    );
    
    this.removeSubview('.stories-column', subview);
  }
});