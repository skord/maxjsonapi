import DS from 'ember-data';

export default DS.Model.extend({
  service: DS.attr('string'),
  router: DS.attr('string'),
  state: DS.attr('string'),
  started: DS.attr('string'),
  rootUserAccess: DS.attr('string'),
  usersData: DS.attr('string'),
  totalConnections: DS.attr('string'),
  currentlyConnected: DS.attr('string'),
  servers: DS.hasMany('server')

});
