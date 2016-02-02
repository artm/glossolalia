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
      this.onEnter(event);
    } else if (backspace(event)) {
      return this.onBackspace(event);
    } else if (deleteKey(event)) {
      return this.onDelete(event);
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
    var paragraphTag = this.selection().startParagraph;
    paragraphTag.pickUpEdits();
    return false;
  }

  onBackspace(event) {
    if (this.selection().multipleParagraphs()) {
      this.deleteLargeSelection(event, true);
    } else if (this.selection().endOffset === 0) {
      this.glueWithPreviousParagraph(event);
    } else {
      // the backspace seems innocent enough, let the browser have at it
      return true;
    }
    return false;
  }

  onDelete(event) {
    if (this.selection().multipleParagraphs()) {
      this.deleteLargeSelection(event, true);
    } else if (this.selection().caretAtParagraphEnd()) {
      this.glueWithNextParagraph(event);
    } else {
      // the delete seems innocent enough, let the browser have at it
      return true;
    }
    return false;
  }

  onEnter(event) {
    var sel = this.selection();
    if (sel.multipleParagraphs()) {
      this.deleteLargeSelection(event, false);
    } else {
      var p = sel.startParagraph;
      opts.stream.breakParagraph(p.i, sel.startOffset, sel.endOffset);
      event.preventUpdate = false;
    }
  }

  deleteLargeSelection(event, andGlueTheEnds) {
  }

  glueWithPreviousParagraph(event) {
  }

  glueWithNextParagraph(event) {
  }

  selection() {
    var sel = rangy.getSelection();
    var startNode = sel.isBackwards() ? sel.focusNode : sel.anchorNode;
    var startOffset = sel.isBackwards() ? sel.focusOffset : sel.anchorOffset;
    var endNode = sel.isBackwards() ? sel.anchorNode : sel.focusNode;
    var endOffset = sel.isBackwards() ? sel.anchorOffset : sel.focusOffset;
    return {
      __proto__: sel,
      startParagraph: $(startNode).closest('p').get(0)._tag,
      startOffset: startOffset,
      endParagraph: $(endNode).closest('p').get(0)._tag,
      endOffset: endOffset,
      multipleParagraphs() {
        return this.startParagraph !== this.endParagraph;
      },
      caretAtParagraphEnd() {
        return this.isCollapsed && this.endOffset === this.endParagraph.displayedText().length;
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
