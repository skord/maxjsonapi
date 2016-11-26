import DS from 'ember-data';

export default DS.Model.extend({
  server: DS.attr(),
  name: DS.attr(),
  status: DS.attr(),
  protocol: DS.attr(),
  port: DS.attr('number'),
  serverVersion: DS.attr(),
  nodeId: DS.attr('number'),
  masterId: DS.attr(),
  slaveIds: DS.attr(),
  replDepth: DS.attr(),
  numberOfConnections: DS.attr('number'),
  currentNoOfConns: DS.attr('number'),
  currentNoOfOperations: DS.attr('number'),
  monitors: DS.hasMany('monitor')
});
