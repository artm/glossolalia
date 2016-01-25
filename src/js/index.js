var realtimeUtils = require('./realtime_utils');
var authorize = require('./authorize');

authorize(setupManualAuthorization, start);

function setupManualAuthorization(onSuccessfulAuthorization) {
  // Authorization failed because this is the first time the user has used your application,
  // show the authorize button to prompt them to authorize manually.
  var button = document.getElementById('auth_button');
  button.classList.add('visible');
  button.addEventListener('click', function onAuthButtonClicked() {
    realtimeUtils.authorize(onSuccessfulAuthorization, true);
  });
}

function start() {
  console.trace('starting');
  var id = realtimeUtils.getParam('id');
  if (id) {
    console.trace('got id:', id);
    realtimeUtils.load(id.replace('/', ''), onFileLoaded, onFileInitialize);
  } else {
    console.trace('got no id, creating a new drive resource');
    realtimeUtils.createRealtimeFile('Glossolalia Dev Stub.gloss', onDriveResourceCreated);
  }
}

function onDriveResourceCreated(createResponse) {
  console.trace('drive resource created', createResponse);
  window.history.pushState(null, null, '?id=' + createResponse.id);
  realtimeUtils.load(createResponse.id, onFileLoaded, onFileInitialize);
}

function onFileInitialize(model) {
  console.trace('initializing a new file', model);
  var s1 = model.createString('Text 1 be here');
  var s2 = model.createString('Text 2 be here');
  var ss = model.createList([s1, s2]);
  model.getRoot().set('streams', ss);
}

function onFileLoaded(doc) {
  // take out doc.getModel().getRoot()... and bind it to UI
  console.trace('file loaded', doc.getModel().toJson());
  var display0 = document.getElementById('stream0');
  var display1 = document.getElementById('stream1');
  var root = doc.getModel().getRoot();
  display0.innerHTML = root.get('streams').get(0).getText();
  display1.innerHTML = root.get('streams').get(1).getText();
}

