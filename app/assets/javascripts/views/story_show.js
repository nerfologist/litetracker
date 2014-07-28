LiteTracker.Views.StoryShow = Backbone.View.extend({
  template: JST['story/show'],
  
  attributes: function () {
    return {
      'class': 'story preview clearfix',
      'data-story-id' : this.model.get('id')
    };
  },
  
  events: {
    'click div.story-controls a.expand'   : 'maximizeStory',
    'click div.story-controls a.trash'    : 'confirmDeleteStory',
    'click button#btn-delete-story'       : 'deleteStory'
  },
  
  initialize: function (options) {
    this.listenTo(this.$('#btn-delete-story'), 'click', this.catchClick);
  },
  
  render: function () {
    var renderedContent = this.template({ story: this.model });
    this.$el.html(renderedContent);
    return this;
  },
  
  maximizeStory: function (event) {
    event.preventDefault();
    $target = $(event.target);
    $target.closest('div.story').toggleClass('preview');
    $target.toggleClass('glyphicon-chevron-right').toggleClass('glyphicon-chevron-down');
  },
  
  confirmDeleteStory: function (event) {
    event.preventDefault();
    
    // attach confirmation modal to this view (to catch events)
    this.$el.append($('#storyDeletionModal'));
    $('#storyDeletionModal').modal();
  },
  
  deleteStory: function (event) {
    var $modal = $('#storyDeletionModal')
    $('#storyDeletionModal').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
    
    // avoid modal being destroyed when tab view removes this view!
    $('.project').append($modal);
    
    this.model.destroy();
    return false;
  }
});