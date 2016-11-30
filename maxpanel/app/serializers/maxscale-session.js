import Ember from 'ember';
import JSONAPISerializer from 'ember-data/serializers/json-api';
import camelcaseKeys from 'npm:camelcase-keys';

export default JSONAPISerializer.extend({
  normalizeFindAllResponse(store, primaryModelClass, payload, id, requestType) {
    var clientsCollection = payload;
    var dataCollection = [];
    Ember.$.map(clientsCollection, function(client){
      var normalizedKeys = camelcaseKeys(client);

      var entry = {
        id: normalizedKeys.session,
        type: primaryModelClass.modelName,
        attributes: {
          'session': normalizedKeys.session,
          'client': normalizedKeys.client,
          'service': normalizedKeys.service,
          'state': normalizedKeys.state
        }
      };
      dataCollection.push(entry);
    });
    var response = {
      data: dataCollection
    };
    return this._super(store, primaryModelClass, response, id, requestType);
  }
});
