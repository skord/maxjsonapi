import ENV from '../config/environment';
import JSONAPIAdapter from 'ember-data/adapters/json-api';

export default JSONAPIAdapter.extend({
  namespace: ENV.APP.ApiNamespace
});
