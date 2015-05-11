LiteTracker.Views.StoryShow = Backbone.View.extend({
  template: JST['story/show'],
  
  attributes: function () {
    "use strict";
    return {
      'class': 'story clearfix ' +
               (this.model.get('maximized') ? 'maximized ' : '') +
               (this.model.get('state')),
      'data-story-id' : this.model.get('id')
    };
  },
  
  events: {
    'click div.story-controls a.expand'        : 'maximizeStory',
    'click div.story-controls a.trash'         : 'confirmDeleteStory',
    'click button#btn-delete-story'            : 'deleteStory',
    'change form#std-attributes'               : 'updateStory',
    'submit form#std-attributes'               : 'updateStory',
    'click button.btn-change-story-state'      : 'advanceStoryState',
    'click button.btn-reject-story'            : 'rejectStory',
    'changeDate input[name="story[deadline]"]' : 'setDeadline'
  },
  
  initialize: function (options) {
    "use strict";
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.$('#btn-delete-story'), 'click', this.catchClick);
    this.listenTo(LiteTracker.Models.dispatcher,
                  'renderComplete', this.onRender);
    this.listenTo(LiteTracker.Models.dispatcher,
                  'tabSortComplete', this.onRender);
  },
  
  render: function () {
    "use strict";
    var renderedContent = this.template({ story: this.model });
    this.$el.html(renderedContent);
    
    this.onRender();
    return this;
  },
  
  onRender: function () {
    // hack to make it work after tab drag&drop
    this.initDatePicker();
  },
  
  maximizeStory: function (event) {
    "use strict";
    event.preventDefault();
    var $target = $(event.target);
    
    // persist maximized
    if(this.model.get('maximized')) {
      this.model.save({ maximized: false });
    } else {
      this.model.save({ maximized: true });
    };
    
    $target.closest('div.story').toggleClass('maximized');
    $target.toggleClass('glyphicon-chevron-right')
           .toggleClass('glyphicon-chevron-down');
  },
  
  confirmDeleteStory: function (event) {
    "use strict";
    event.preventDefault();
    
    // attach confirmation modal to this view (to catch events)
    this.$el.append($('#storyDeletionModal'));
    $('#storyDeletionModal').modal();
  },
  
  deleteStory: function (event) {
    "use strict";
    var $modal = $('#storyDeletionModal');
    $('#storyDeletionModal').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
    
    // avoid modal being destroyed when tab view removes this view!
    $('.project').append($modal);
    
    this.model.destroy();
    return false;
  },
  
  updateStory: function (event) {
    "use strict";
    event.preventDefault();

    var storyParams = this.$('form#std-attributes').serializeJSON().story;
    this.model.save(storyParams);
  },
  
  advanceStoryState: function (event) {
    "use strict";
    event.preventDefault();
    if (event.clientX === 0 && event.clientY === 0) {
      // bogus fake click from submitting std attributes form with 'return'
      return false;
    }
    
    switch(this.model.get('state')) {
    case 'started':
      this.model.set('state', 'finished')
      this.setStateClass('finished');
      break;
    case 'finished':
      this.model.accept();
      break;
    case 'unstarted':
    case 'rejected':
    case 'accepted':
      this.model.start();
    }
    
    this.model.save();
  },
  
  setStateClass: function (newClass) {
    this.$el.removeClass('unstarted started finished rejected accepted');
    this.$el.addClass(newClass);
  },
  
  rejectStory: function (event) {
    "use strict";
    
    this.model.save( { state: 'rejected' });
  },
  
  initDatePicker: function () {
    this.$("input[name='story[deadline]']").datepicker({
        orientation: "bottom auto",
        autoclose: true,
        clearBtn: true,
        daysOfWeekDisabled: [0, 6],
        todayHighlight: true,
        todayBtn: 'linked'
    });
  },
  
  setDeadline: function (event) {
    if (event.date) {
      if (event.date.getTime() !== (new Date(this.model.get('deadline'))).getTime()) {
        this.model.set('deadline', event.date);
        this.model.save();
      }
    } else {
      this.model.set('deadline', null);
      this.model.save();
    }
  }
});
