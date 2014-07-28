LiteTracker.Views.TabShow = Backbone.CompositeView.extend({
  template: JST['tab/show'],
  
  attributes: function () {
    return {
      'class'               : 'tab col-xs-3 ' +
                              (this.model.get('visible') ? 'visible' : ''),
      'id'                  : 'tab-' + this.model.escape('name'),
      'data-id'             : this.model.get('id'),
      'data-target-nav-btn' : '#nav-visible-' + this.model.escape('name')
    }
  },
  
  render: function () {
    var renderedContent = this.template({ tab: this.model });
    this.$el.html(renderedContent);
    return this;
  }
});