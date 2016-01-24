var clientId = '374207887542-84o0a3vmdl28avsg6232kmes45udaqqd.apps.googleusercontent.com';
var realtimeUtils = new utils.RealtimeUtils({ clientId: clientId });

authorize();

function authorize() {
  // Attempt to authorize
  realtimeUtils.authorize(function(response){
    if(response.error){
      showAuthorizeButton();
    } else {
      start();
    }
  }, false);
}

function showAuthorizeButton() {
  // Authorization failed because this is the first time the user has used your application,
  // show the authorize button to prompt them to authorize manually.
  var button = document.getElementById('auth_button');
  button.classList.add('visible');
  button.addEventListener('click', function () {
    realtimeUtils.authorize(function(response){
      start();
    }, true);
  });
}

// Load the Realtime API, no auth needed.
window.gapi.load('auth:client,drive-realtime,drive-share', start);

function start() {
  var doc = new GlossolaliaDoc();
  console.log(doc.model.toJson());
}

function GlossolaliaDoc() {
  this.doc = gapi.drive.realtime.newInMemoryDocument();
  this.model = this.doc.getModel();
  this.streams = this.model.createList();
  this.model.getRoot().set('streams', this.streams);

  var masterStream = this.createStream();
  this.streams.push(masterStream);
  masterStream.appendFragment("Here be content");
}

GlossolaliaDoc.prototype.createStream = function() {
  var doc = this;
  var stream = this.model.createMap({ title: 'new text', language: 'en' });
  var fragments = this.model.createList();
  stream.set('fragments', fragments);

  stream.appendFragment = function(text) {
    text = doc.model.createString(text);
    fragments.push(text);
  }

  return stream;
}
