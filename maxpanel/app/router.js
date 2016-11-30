import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('variables', function() {});
  this.route('status', function() {});
  this.route('services', function() {
    this.route('show', { path: '/:service_id'});
  });
  this.route('listeners', function() {});
  this.route('modules', function() {});
  this.route('sessions');
  this.route('clients', function() {});
  this.route('servers', function() {
    this.route('show', { path: ':server_id'});
    this.route('new');
    this.route('edit', { path: ':server_id/edit'});
  });
  this.route('events', function() {});
  this.route('welcome', function() {});
  this.route('maxscale_sessions', function() {});

  this.route('event', function() {});
  this.route('maxscale_session');
  this.route('error', function() {});
  this.route('monitors', function() {
    this.route('show', {path: ':monitor_id'});
  });
});

export default Router;
