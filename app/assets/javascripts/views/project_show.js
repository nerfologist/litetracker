(function () {
  'use strict';

  LiteTracker.Views.ProjectShow = Backbone.CompositeView.extend({
    template: JST['project/show'],

    attributes: {
      'class': 'project'
    },

    initialize: function () {
      var view = this;

      this.listenTo(this.model, 'sync', this.render);
      this.listenTo(this.model.tabs(), 'add', this.addTab);
      this.listenTo(LiteTracker.Models.dispatcher,
        'renderComplete', this.onRender);

      this.model.tabs().each(function (tab) {
        view.addTab(tab);
      });
    },

    events: {
      'click a.tab-button': 'toggleTabVisible',
      'sortupdate div#tabs-row': 'persistTabOrder',
      'click .btn-create-story': 'createStory',
      'click li#nav-destroy-project': 'confirmDeleteProject',
      'click li#nav-change-capacity': 'showChangeCapacityModal',
      'click button#btn-delete-project': 'deleteProject',
      'slide #capacitySlider': 'handleCapacitySlide',
      'click button#btn-set-capacity': 'changeCapacity'
    },

    addTab: function (tab) {
      var tabView = new LiteTracker.Views.TabShow({
        model: tab
      });
      this.addSubview('#tabs-row', tabView);
    },

    render: function () {
      var renderedContent = this.template({
        project: this.model
      });
      this.$el.html(renderedContent);

      this.attachSubviews();
      this.updateVisibleTabsAndButtons();

      // signal views that rendering is done so they can setup
      // sortables, datepickers, etc
      LiteTracker.Models.dispatcher.trigger('renderComplete');
      return this;
    },

    onRender: function () {
      this.setupSortables();
      this.setupSlider();
    },

    setupSortables: function () {
      this.$('#tabs-row').sortable({
        axis: 'x',
        cursor: 'move',
        distance: 5
      });
    },

    setupSlider: function () {
      $('.slider').slider();
      $('.slider.slider-horizontal').css('width', '90%');
    },

    persistTabOrder: function (event) {
      var that = this;
      var $tabColumns = $(event.target).find('.tab-column');
      $tabColumns.each(function (idx) {
        var tabModel = that.model.tabs().sort().get($(this).data('tab-id'));
        tabModel.set('ord', idx);
        tabModel.save();
      });

      // used by stries to refresh datepicker()s
      LiteTracker.Models.dispatcher.trigger('tabSortComplete');
    },

    toggleTabVisible: function (event) {
      var $anchor, $targetTabColumn, tabModel;
      event.preventDefault();

      // works for: navbar buttons; tab 'x' buttons (event.target is a span there)
      $anchor = $(event.target).closest('a');
      $targetTabColumn = $($anchor.data('target'));
      tabModel = this.model.tabs().get($targetTabColumn.data('tab-id'));

      $anchor.closest('li').toggleClass('active');
      $targetTabColumn.toggleClass('hidden');

      this.updateVisibleTabsAndButtons();

      // update tab model with new visibility
      tabModel.set('visible', !$targetTabColumn.hasClass('hidden'));
      tabModel.save();
    },

    updateVisibleTabsAndButtons: function () {
      var $visibleTabs, $allTabs;
      // resize visible tabs to cover grid space
      $visibleTabs = this.$('div.tab-column').not('.hidden');

      $visibleTabs.each(function () {
        $(this).removeClass('col-xs-12 col-xs-6 col-xs-4 col-xs-3')
          .addClass('col-xs-' + (12 / $visibleTabs.length));
      });

      // update visibility buttons
      $allTabs = this.$('div.tab-column');

      $allTabs.each(function () {
        if (!$(this).hasClass('hidden')) {
          $($(this).data('target-nav-btn')).addClass('active');
        } else {
          $($(this).data('target-nav-btn')).removeClass('active');
        }
      });
    },

    createStory: function (event) {
      var params, $inputField, icebox, ord;
      event.preventDefault();

      params = $(event.target).closest('form').serializeJSON().story;
      $inputField = $('#input-story-title');

      if ($.trim(params.title) === '') {
        $inputField.closest('.form-group').addClass('has-error');
        $inputField.attr('placeholder', 'insert story title here');
        $inputField.focus();
        return;
      }

      $inputField.closest('.form-group').removeClass('has-error');

      icebox = this.model.tabs().find(function (tab) {
        return tab.get('name') === 'icebox';
      });

      ord = (icebox.stories().length > 0) ?
        _.max(icebox.stories().pluck('ord')) + 1 : 0;

      $('#input-story-title').val('');

      icebox.stories().create({
        title: params.title,
        tab_id: icebox.id,
        ord: ord
      }, {
        wait: true
      });
    },

    confirmDeleteProject: function (event) {
      event.preventDefault();

      $('#projectDeletionModal').modal();
    },

    deleteProject: function (event) {
      event.preventDefault();

      $('#projectDeletionModal').modal('hide');
      $('body').removeClass('modal-open');
      $('.modal-backdrop').remove();

      this.model.destroy({
        success: function () {
          Backbone.history.navigate('/', {
            trigger: true
          });
        }
      });
    },

    showChangeCapacityModal: function (event) {
      event.preventDefault();

      $('#changeCapacityModal').modal();
    },

    handleCapacitySlide: function (event) {
      this.$('#capacity-value').text(event.value);
    },

    changeCapacity: function () {
      var newCapacity = $('#capacitySlider').val();
      this.model.set('capacity', newCapacity);

      $('#changeCapacityModal').modal('hide');
      $('body').removeClass('modal-open');
      $('.modal-backdrop').remove();

      this.model.save();
    }
  });

}());
