import DS from 'ember-data';

export default DS.Model.extend({
  session: DS.attr('string'),
  client: DS.attr('string'),
  service: DS.attr('string'),
  state: DS.attr('string')
});
