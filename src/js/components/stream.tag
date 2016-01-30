import './paragraph.tag';
import rangy from 'rangy';
import 'rangy/lib/rangy-textrange';

<stream>
  <h1>{ title }</h1>
  <section>
    <p
      contenteditable
      riot-tag='paragraph'
      each={ paragraphs }
      paragraph={ this }
      onkeydown={ onKeydown }
      onkeypress={ onKeypress }
      oncut={ onCut }
      onpaste={ onPaste }
    />
  </section>

  this.on('update', function() {
    console.trace('stream update');
    this.title = opts.stream.get('title').text;
    this.paragraphs = opts.stream.get('paragraphs').asArray();
    return true;
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
    console.trace('onEnter', event);
    var selection = rangy.getSelection();
    switch(selection.nativeSelection.type) {
      case 'Caret':
        var paragraphNode = event.target;
        var range = selection.getRangeAt(0).toCharacterRange(paragraphNode);
        opts.stream.breakParagraph(event.item, range.start);
        event.preventUpdate = false;
        console.trace('todo: put caret in the new paragraph');
        break;
      case 'Range':
        console.trace('todo: remove selection then do the enter handling');
        break;
    }
  }
</stream>
