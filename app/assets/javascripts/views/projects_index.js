LiteTracker.Views.ProjectsIndex = Backbone.View.extend({
  template: JST['project/index'],
  
  attributes: {
    class: 'container'
  },
  
  events: {
    'shown.bs.modal div#projectCreationModal' : 'focusTitleInput',
    'click button#btn-create-project' : 'createProject',
    'submit form' : 'createProject',
    'click a.sortBy' : 'sortBy'
  },
  
  initialize: function (options) {
    this.listenTo(this.collection, 'sync', this.render);
  },
  
  render: function () {
    var renderedContent = this.template({ projects: this.collection });
    this.$el.html(renderedContent);
    return this;
  },
  
  focusTitleInput: function (event) {
    $('input#project-title').focus();
  },
  
  createProject: function (event) {
    event.preventDefault();
    
    var that = this;
    var $form = this.$('form');
    var project = new LiteTracker.Models.Project($form.serializeJSON()['project'])

    $('#projectCreationModal').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();

    project.save({}, {
      success: function () {
        that.collection.add(project);
      }
    });
  },
  
  sortBy: function (event) {
    this.collection.comparator = $(event.target).data('sortby');
    this.collection.sort();
    this.render();
  },
});