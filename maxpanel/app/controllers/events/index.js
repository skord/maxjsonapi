import Ember from 'ember';
// import defaultTheme from '../themes/default-theme';

export default Ember.Controller.extend({
    isShowingGraph: true,
    actions: {
      toggleGraph: function() {
        this.toggleProperty('isShowingGraph');
        this.toggleProperty('isShowingTable');
      }
    },
    chartOptions: Ember.computed('model', function(){
      return {
        chart: {
          type: "column"
        },
        title: {
          text: "Events"
        },
        xAxis: {
          categories: this.get('model').mapBy('duration')
        },
        yAxis: {
          title: {
            text: 'Event Count'
          }
        }
      };
    }),

    chartData: Ember.computed('model.@each.queued', function() {
      return (
        [{
          name: 'Queued',
          data: this.get('model').mapBy('queued')
        }, {
          name: 'Executed',
          data: this.get('model').mapBy('executed')
        }]
    );
  })

});
