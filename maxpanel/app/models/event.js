import DS from 'ember-data';

export default DS.Model.extend({
  duration: DS.attr('string'),
  queued: DS.attr('number'),
  executed: DS.attr('number')
});
