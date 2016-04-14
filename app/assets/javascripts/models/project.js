(function () {
  'use strict';

  LiteTracker.Models.Project = Backbone.Model.extend({
    defaults: {},

    urlRoot: '/api/projects',

    parse: function (payload) {
      if (payload.tabs) {
        this.tabs().set(payload.tabs);
        delete payload.tabs;
      }

      return payload;
    },

    tabs: function () {
      this._tabs = this._tabs ||
      new LiteTracker.Collections.Tabs([], {
        project: this
      });

      return this._tabs;
    },

    findTab: function (tabName) {
      return this.tabs().find(function (tab) {
        return tab.get('name') === tabName;
      });
    },

    current: function () {
      return this.findTab('current');
    },

    backlog: function () {
      return this.findTab('backlog');
    },

    done: function () {
      return this.findTab('done');
    },

    moveToTab: function (story, newTab) {
      var maxOrd;
      var project = this;

      if (newTab.stories().length === 0) {
        maxOrd = -1; // will become 0
      } else {
        maxOrd = _.max(newTab.stories().pluck('ord'));
      }

      story.save({
        tab_id: newTab.id,
        ord: maxOrd + 1
      }, {
        success: function () {
          story.collection.remove(story);
          newTab.stories().add(story);
          project.populateCurrent();
        }
      });
    },

    requestStateChange: function (story, newState) {
      story.set('state', newState);

      switch (newState) {
        case 'started':
          if (this.current().points() + story.get('points') <= this.get('capacity')) {
            // move to current
            this.moveToTab(story, this.current());
          } else {
            // move to backlog
            this.moveToTab(story, this.backlog());
          }
          break;
        case 'accepted':
          story.set({
            maximized: false
          });
          this.moveToTab(story, this.done());
          break;
        default:
          story.save();
          break;
      }
    },

    availablePoints: function () {
      return this.get('capacity') - this.current().points();
    },

    // see if there are started stories in the backlog and bring them to current
    populateCurrent: function () {
      var project = this;
      var movedPoints = 0;

      // TODO: move this to server side
      this.backlog().stories().sort().each(function (story) {
        if (project.availablePoints() - movedPoints >= story.get('points')) {
          movedPoints += story.get('points');
          project.moveToTab(story, project.current());
        }
      });
    }
  });

}());
