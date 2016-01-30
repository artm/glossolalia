import './paragraph.tag'

<stream>
  <h1>{ title }</h1>
  <section
    onkeydown={ onKeydown }
    onkeypress={ onKeypress }
    oncut={ onCut }
    onpaste={ onPaste }
    >
    <p riot-tag='paragraph' each={ paragraphs } paragraph={ this } contenteditable/>
  </section>

  this.title = opts.stream.get('title').text;
  this.paragraphs = opts.stream.get('paragraphs').asArray();

  this.on('all', function(eventName) {
    console.trace('riot event', eventname, this, arguments);
  });

  hasSelection() {
    return !window.getSelection().isCollapsed;
  }

  hasSelectionAcrossParagraphs() {
    return this.hasSelection();
  }

  onKeydown(event) {
    console.trace('keydown');
    event.preventUpdate = true;
    if (event.keyIdentifier === 'Enter') {
      this.onEnter(event);
      return false;
    } else if (event.code === 'Delete') {
      console.trace('handle delete (perhaps remove paragraph)');
    } else if (event.code === 'Backspace') {
      console.trace('handle backspace (perhaps remove paragraph)');
      return true;
    } else {
      return true;
    }
  }

  onKeypress(event) {
    console.trace('keypress');
    if (this.hasSelectionAcrossParagraphs()) {
      console.trace('handle type-over (remove paragraphs)');
    } else {
      return true;
    }
  }

  onCut(event) {
    console.trace('cut');
    event.preventUpdate = true;
    console.trace('handle cut (perhaps remove paragraphs)');
  }

  onPaste(event) {
    console.trace('paste');
    event.preventUpdate = true;
    if (this.hasSelectionAcrossParagraphs()) {
      console.trace('handle paste-over (remove paragraphs)');
    } else if (this.hasSelection()) {
      console.trace('handle paste-over (remove selection)');
    }
    console.trace('handle paste (perhaps insert paragraphs)');
  }

  onEnter(event) {
    var selection = window.getSelection();
    var paragraphNode = event.target;
    var paragraph = paragraphNode._tag;
    console.trace('onEnter', event);
    switch(selection.type) {
      case 'Caret':
        console.trace('todo: enter new paragraph at', paragraphNode, selection, selection.getRangeAt(0));
        break;
      case 'Range':
        console.trace('todo: remove selection then do the enter handling');
        break;
    }
  }
</stream>
