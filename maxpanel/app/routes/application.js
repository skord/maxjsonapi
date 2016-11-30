import Ember from 'ember';
import LoadingSliderMixin from '../mixins/loading-slider';

export default Ember.Route.extend(LoadingSliderMixin,{
actions: {

  // error(error, transition) {
  //   this.transitionTo('error');
  // }
}}
);
