import Ember from 'ember';

export function listenerRowState(params/*, hash*/) {
  var downConditions = ["Stopped","Down","Slave, Down", "Auth Error, Down"];
  var warningConditions = ["In Development", "Alpha", "Beta"];
  if (downConditions.includes(params.toString()))  {
    return "negative";
  } else if (warningConditions.includes(params.toString())){
    return "warning";
  } else {
    return "";
  }

}

export default Ember.Helper.helper(listenerRowState);
