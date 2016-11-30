import Ember from 'ember';

export default Ember.Component.extend({
  inError: false,
  isValid: Ember.computed(
    'model.server',
    'model.name',
    'model.port',
    {
      get() {
        return !Ember.isEmpty(this.get('model.server')) &&
        !Ember.isEmpty(this.get('model.name')) &&
        !Ember.isEmpty(this.get('model.port'));
      }
    }
  ),
  actions: {
    save() {
        this.get("model").save().then((server) => {
          return this.save(server);
        }, (err) => {
          this.set('inError', true);
          this.set('errorMessage', "There were errors saving this server:");
        });

    },
    cancel() {
      this.cancel(this.get('model'));
    },
    error() {
      this.set('inError', true);
    }

  }
});
