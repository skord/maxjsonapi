import Ember from 'ember';

export default Ember.Controller.extend({

  allMonitors: Ember.computed(function(){
    return this.store.findAll('monitor');
  }),
  allServices: Ember.computed(function(){
    return this.store.findAll('service');
  }),
  inError: false,
  isValid: Ember.computed(
    'model.name',
    'model.port',
    {
      get() {
        return !Ember.isEmpty(this.get('model.name')) &&
               !Ember.isEmpty(this.get('model.port'));
      }
    }
  ),
  actions: {
    save() {
      this.get("model").save().then((server) => {
        this.transitionToRoute("servers.show", server);
      }, (err) => {
        this.set('inError', true);
        this.set('errorMessage', "There were errors saving this server: ");
      });
    },
    cancel() {

      this.transitionToRoute("servers.show", this.get('model'));
      return false;
    }
  }
});
