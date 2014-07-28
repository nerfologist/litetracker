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
  
  render: function () {
    var renderedContent = this.template({ tab: this.model });
    this.$el.html(renderedContent);
    return this;
  }
});