var realtimeUtils = require('./realtime_utils');

module.exports = function authorize(setupManualAuthorization, onSuccessfulAuthorization) {
  console.trace('trying to authorize');
  realtimeUtils.authorize(function authorizeCallback(response){
    if(response.error){
      console.trace('auth failed, ask user to authorize manually', response);
      setupManualAuthorization(onSuccessfulAuthorization);
    } else {
      console.trace('auth succeeded', response);
      onSuccessfulAuthorization();
    }
  }, false);
}

