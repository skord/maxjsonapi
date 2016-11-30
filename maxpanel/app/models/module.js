import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  type: DS.attr('string'),
  version: DS.attr('string'),
  apiversion: DS.attr('string'),
  status: DS.attr('string')
});
