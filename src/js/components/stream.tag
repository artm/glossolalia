import './paragraph.tag';
import rangy from 'rangy';
import 'rangy/lib/rangy-textrange';
import $ from 'jquery';

<stream>
  <h1>{ title }</h1>
  <section contenteditable
    onkeydown={ onKeydown }
    onkeypress={ onKeypress }
    oncut={ onCut }
    onpaste={ onPaste }
    oninput={ onInput } >
    <p
      riot-tag='paragraph'
      each={ p,i in paragraphs }
      paragraph={ p }
      oninput={ onInput }
    />
  </section>

  this.on('update', function() {
    console.trace('stream update');
    this.title = opts.stream.title()
    this.paragraphs = opts.stream.paragraphs();
  });

  onKeydown(event) {
    console.trace(event.type, event);
    event.preventUpdate = true;
    if (motion(event)) {
      // allow motion with arrow keys
      return true;
    } else if (enter(event)) {
    } else if (backspace(event)) {
      return this.onBackspace(event);
    } else if (deleteKey(event)) {
    } else if (!event.altKey && !event.ctrlKey && !event.metaKey) {
      return true;
    }
    return false;
  }

  onKeypress(event) {
    console.trace(event.type, event);
    event.preventUpdate = true;
    return !this.selection().multipleParagraphs();
  }

  onCut(event) {
    console.trace(event.type, event);
    event.preventUpdate = true;
    return false;
  }

  onPaste(event) {
    console.trace(event.type, event);
    event.preventUpdate = true;
    return false;
  }

  onInput(event) {
    console.trace(event.type, event);
    event.preventUpdate = true;
    /*
     * only single paragraph edits will get here, so the paragraph of the caret is where it's at
     */
    var paragraphTag = this.selection().anchorParagraph;
    paragraphTag.pickUpEdits();
    return false;
  }

  onBackspace(event) {
    if (this.selection().multipleParagraphs()) {
      this.deleteLargeSelection(event);
    } else if (this.selection().focusParagraphOffset === 0) {
      this.glueParagraphUp(event);
    } else {
      // the backspace seems innocent enough, let the browser have at it
      return true;
    }
    return false;
  }

  deleteLargeSelection(event) {
  }

  glueParagraphUp(event) {
    // from selection to the previous
  }

  selection() {
    var sel = rangy.getSelection();
    return {
      __proto__: sel,
      anchorParagraph: $(sel.anchorNode).closest('p').get(0)._tag,
      anchorParagraphOffset: sel.anchorOffset,
      focusParagraph: $(sel.focusNode).closest('p').get(0)._tag,
      focusParagraphOffset: sel.focusOffset,
      multipleParagraphs() {
        return this.anchorParagraph != this.focusParagraph;
      }
    };
  }

  function motion(event) {
    return event.code.startsWith('Arrow') || event.code === 'Home' || event.code === 'End';
  }

  function enter(event) {
    return event.code === 'Enter';
  }

  function backspace(event) {
    return event.code === 'Backspace';
  }

  function deleteKey(event) {
    return event.code === 'Delete';
  }
</stream>
