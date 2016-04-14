(function () {
  'use strict';

  LiteTracker.Views.ProjectsIndex = Backbone.View.extend({
    events: {
      'shown.bs.modal div#projectCreationModal': 'focusTitleInput',
      'show.bs.modal div#projectDeletionModal': 'setDeletionTarget',
      'click button#btn-create-project': 'createProject',
      'click button#btn-delete-project': 'deleteProject',
      'submit form': 'createProject',
      'click a.sortBy': 'sortBy'
    },

    initialize: function () {
      this.listenTo(this.collection, 'sync remove', this.render);
    },

    template: JST['project/index'],

    attributes: {
      'class': 'container'
    },

    render: function () {
      var renderedContent = this.template({
        projects: this.collection
      });
      this.$el.html(renderedContent);
      return this;
    },

    focusTitleInput: function () {
      $('input#project-title').focus();
    },

    createProject: function (event) {
      var that = this;
      var $form, project;

      event.preventDefault();

      $form = this.$('form');
      project = new LiteTracker.Models
        .Project($form.serializeJSON().project);

      $('#projectCreationModal').modal('hide');
      $('body').removeClass('modal-open');
      $('.modal-backdrop').remove();

      project.save({}, {
        success: function () {
          that.collection.add(project);
        }
      });
    },

    setDeletionTarget: function (event) {
      var projectId = $(event.relatedTarget).data('project-id');
      this.$('#btn-delete-project').attr('data-project-id', projectId);
    },

    deleteProject: function (event) {
      var that = this;
      var projectId = $(event.target).data('project-id');
      var project = this.collection.get(projectId);

      $('#projectDeletionModal').modal('hide');
      $('body').removeClass('modal-open');
      $('.modal-backdrop').remove();

      project.destroy({
        success: function () {
          that.collection.remove(project);
        }
      });
    },

    sortBy: function (event) {
      this.collection.comparator = $(event.target).data('sortby');
      this.collection.sort();
      this.render();
    }
  });

}());
