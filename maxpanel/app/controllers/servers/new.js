import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    save(model) {
      this.transitionToRoute('servers.show', model);
    },
    cancel() {
      this.transitionToRoute('servers.index');
      return false;
    }
  }
});
