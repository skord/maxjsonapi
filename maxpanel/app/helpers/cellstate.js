import Ember from 'ember';

export function cellstate(params/*, hash*/) {
  var downConditions = ["Stopped","Down"];
  var upConditions = ["Running", "Slave, Running", "Master, Running","GA"];
  var warningConditions = ["In Development", "Alpha", "Beta"];
  if (downConditions.includes(params.toString()))  {
    return "negative";
  } else if (upConditions.includes(params.toString())) {
    return "positive";
  } else if (warningConditions.includes(params.toString())){
    return "warning";
  } else {
    return "";
  }
}

export default Ember.Helper.helper(cellstate);
