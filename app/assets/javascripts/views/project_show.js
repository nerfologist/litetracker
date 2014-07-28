LiteTracker.Views.ProjectShow = Backbone.CompositeView.extend({
  template: JST['project/show'],
  
  attributes: {
    class: 'project'
  },
  
  initialize: function (options) {
    var view = this;
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.tabs(), 'add', this.addTab)
    
    this.model.tabs().each(function (tab) {
      view.addTab(tab);
    });
  },
  
  events: {
    'click a.tab-button': 'toggleTabVisible',
    'sortupdate div#tabs-row': 'persistTabOrder'
  },
  
  addTab: function (tab) {
    var tabView = new LiteTracker.Views.TabShow({ model: tab });
    this.addSubview('#tabs-row', tabView);
  },
  
  render: function () {
    var renderedContent = this.template({ project: this.model });
    this.$el.html(renderedContent);
    
    this.attachSubviews();
    this.updateVisibleTabsAndButtons();
    
    // needs to be called after all DOM elements are in place
    this.setupSortables();
    
    return this;
  },
  
  setupSortables: function () {
    this.$('#tabs-row').sortable({
      containment: 'parent',
      cursor: 'move',
      distance: 5
    });
  },
  
  persistTabOrder: function (event) {
    var that = this;
    $tabs = $(event.target).find('.tab');
    $tabs.each(function (idx) {
      var tabModel = that.model.tabs().sort().get($(this).data('id'));
      tabModel.set('ord', idx)
      tabModel.save();
    });
  },
  
  toggleTabVisible: function (event) {
    // works for: navbar buttons; tab 'x' buttons (event.target is a span there)
    var $anchor = $(event.target).closest('a');
    
    var $targetTab = $($anchor.data('target'));
    var tabModel = this.model.tabs().get($targetTab.data('id'));
    
    event.preventDefault();
    
    $anchor.closest('li').toggleClass('active');
    $targetTab.toggleClass('visible');
    
    this.updateVisibleTabsAndButtons();

    // update tab model with new visibility
    tabModel.set('visible', $targetTab.hasClass('visible'))
    tabModel.save();
  },
  
  updateVisibleTabsAndButtons: function () {
    // resize visible tabs to cover grid space
    var $visibleTabs = this.$('div.tab.visible');
    $visibleTabs.each(function (idx) {
      $(this).removeClass('col-xs-12 col-xs-6 col-xs-4 col-xs-3')
             .addClass('col-xs-' + (12 / $visibleTabs.length));
    });
    
    // update visibility buttons
    var $allTabs = this.$('div.tab');
    $allTabs.each(function (idx) {
      if ($(this).hasClass('visible')) {
        $($(this).data('target-nav-btn')).addClass('active');
      } else {
        $($(this).data('target-nav-btn')).removeClass('active');
      }
    });
  }
});