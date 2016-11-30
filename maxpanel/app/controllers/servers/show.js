import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    openModal: function(name) {
      // alert('hi')
      Ember.$('.ui.' + name + '.modal').modal('show');
    },
    approveDeleteModal: function(element, component) {
      this.get('model').destroyRecord().then(() => {
        this.transitionToRoute("servers.index");
      });
      return true;
    },
    cancelModal: function() {
      return true;
    }
  }
});
