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

  hasSelection() {
    return !document.getSelection().isCollapsed;
  }

  hasSelectionAcrossParagraphs() {
    return this.hasSelection();
  }

  onKeydown(event) {
    if (event.keyIdentifier === 'Enter') {
      console.trace('handle enter (new paragraph)');
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
    if (this.hasSelectionAcrossParagraphs()) {
      console.trace('handle type-over (remove paragraphs)');
    } else {
      return true;
    }
  }

  onCut(event) {
    console.trace('handle cut (perhaps remove paragraphs)');
  }

  onPaste(event) {
    if (this.hasSelectionAcrossParagraphs()) {
      console.trace('handle paste-over (remove paragraphs)');
    } else if (this.hasSelection()) {
      console.trace('handle paste-over (remove selection)');
    }
    console.trace('handle paste (perhaps insert paragraphs)');
  }
</stream>
