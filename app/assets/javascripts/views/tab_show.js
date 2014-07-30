LiteTracker.Views.TabShow = Backbone.CompositeView.extend({
  template: JST['tab/show'],
  
  attributes: function () {
    "use strict";
    return {
      'class'               : 'col-xs-3 tab-column' +
                              (this.model.get('visible') ? '' : ' hidden'),
      'id'                  : 'tab-column-' + this.model.escape('name'),
      'data-tab-id'         : this.model.get('id'),
      'data-target-nav-btn' : '#nav-visible-' + this.model.escape('name')
    };
  },
  
  events: {
    'sortupdate div.stories-column'   : 'persistStoryOrder',
    'sortremove div.stories-column'   : 'dragStory',
    'sortreceive div.stories-column'  : 'dropStory'
  },
  
  initialize: function () {
    "use strict";
    var view = this;
    
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.stories(), 'add', this.addStory);
    this.listenTo(this.model.stories(), 'remove', this.removeStory);
    this.listenTo(this.model.stories(), 'sync', this.refreshSortables);
    
    this.model.stories().each(function (story) {
      view.addStory(story);
    });
  },
  
  render: function () {
    "use strict";
    var renderedContent = this.template({ tab: this.model });
    this.$el.html(renderedContent);
    
    this.attachSubviews();
    
    this.$('div.stories-column').sortable({
      connectWith: 'div.stories-column'
    });

    return this;
  },
  
  addStory: function (story) {
    "use strict";
    var storyView = new LiteTracker.Views.StoryShow({ model: story });
    this.addSubview('.stories-column', storyView);
  },
  
  removeStory: function (story) {
    "use strict";
    var subview = _.find(
      this.subviews('.stories-column'), function (subview) {
        return subview.model === story;
      }
    );
    
    this.removeSubview('.stories-column', subview);
  },
  
  persistStoryOrder: function (event) {
    "use strict";
    event.stopPropagation();
    
    var view = this;
    var $target = $(event.target);
    
    var tabId = $target.closest('.tab-column').data('tab-id');
    var $storyEls = $target.find('.story');
    
    $storyEls.each(function (idx) {
      var storyModel = view.model.stories().get($(this).data('story-id'));
      storyModel.save({ ord: idx, tab_id: tabId });
    });
  },
  
  dragStory: function (event, ui) {
    "use strict";
    event.stopPropagation();
    
    var story = this.model.stories().get($(ui.item).data('story-id'));
    this.model.stories().remove(story);
    LiteTracker.Collections.tempStories.add(story);
  },
  
  dropStory: function (event, ui) {
    "use strict";
    event.stopPropagation();
    
    var story = LiteTracker.Collections.
                  tempStories.get($(ui.item).data('story-id'));
    LiteTracker.Collections.tempStories.remove(story);
    this.model.stories().add(story);
  },
  
  refreshSortables: function (event) {
    this.$('.stories-column').sortable("refreshPositions");
  }
});