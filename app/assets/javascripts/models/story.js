LiteTracker.Models.Story = Backbone.Model.extend({
  validate: function (attributes, options) {
    if (attributes['ord'] < 0) {
      return 'ord cannot be less than 0';
    } else if (attributes['title'] === '') {
      return 'title cannot be blank';
    }
  }
});