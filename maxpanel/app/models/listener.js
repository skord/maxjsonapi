import DS from 'ember-data';

export default DS.Model.extend({
  serviceName: DS.attr('string'),
  protocolModule: DS.attr('string'),
  address: DS.attr('string'),
  port: DS.attr('string'),
  state: DS.attr('string')
});
