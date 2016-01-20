
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
