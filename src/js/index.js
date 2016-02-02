import realtimeUtils from './realtime_utils';
import authorize from './authorize';
import './components/editor.tag';
import Document from './models/document';
import Paragraph from './models/paragraph';

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
  console.trace('initializing a new file');
  var s1 = createStream(model, {title: 'Text 1', text: 'Text 1 be here'});
  var s2 = createStream(model, {title: 'Text 2', text: 'Text 2 be here'});
  var ss = model.createList([s1, s2]);
  model.getRoot().set('streams', ss);
}

function onFileLoaded(doc) {
  console.trace('file loaded');
  var model = doc.getModel();
  var root = model.getRoot();
  var wrappedDocument = Document.wrap(model, root);
  riot.mount('editor', wrappedDocument);
}

function createStream(model, options) {
  console.trace('creating stream', options);
  var title = model.createString(options.title);
  console.trace('title:', title);
  var paragraphs = model.createList([
    Paragraph.create(model, options.text || 'Placeholder')
  ]);
  var stream = model.createMap({
    title: title,
    paragraphs: paragraphs,
  });

  return stream;
}
