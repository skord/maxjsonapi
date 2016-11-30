import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.findAll('server', {reload: true});
  },
  setupController: function(controller, model) {
    this._super(controller, model);
    this.startRefreshing();
  },
  startRefreshing: function() {
    this.set('refreshing', true);
    Ember.run.later(this, this.refresh, 5000);
  },
  refresh: function() {
    if (!this.get('refreshing')) {
      return;
    } else {
      var self = this;
      self.send('loading');
      let userPromise = this.store.findAll('server', {reload: true});
      userPromise.catch(() => {
        return this.transitionTo("error");
      }).finally(() => {
        self.send('finished');
      });

      Ember.run.later(this, this.refresh, 5000);
      return userPromise;
    }
  },
  actions: {
    willTransition: function() {
      this.set('refreshing', false);
    }
  }
});
