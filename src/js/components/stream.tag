import './paragraph.tag';
import rangy from 'rangy';
import 'rangy/lib/rangy-textrange';

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
    />
  </section>

  this.on('update', function() {
    console.trace('stream update');
    this.title = opts.stream.title()
    this.paragraphs = opts.stream.paragraphs();
  });

  onKeydown(event) {
    console.trace(event.type, event, this.selection());
    event.preventUpdate = true;
    if (motion(event)) {
      // allow motion with arrow keys
      return true;
    } else if (enter(event)) {
    } else if (backspace(event)) {
    } else if (deleteKey(event)) {
    } else if (!event.altKey && !event.ctrlKey && !event.metaKey) {
      return true;
    }
    return false;
  }

  onKeypress(event) {
    console.trace(event.type, event);
    event.preventUpdate = true;
    return !hasSelectionAcrossParagraphs();
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
    return false;
  }

  selection() {
    var sel = rangy.getSelection();
    sel.anchorParagraph = 'unknown';
    sel.anchorParagraphOffset = sel.anchorOffset;
    sel.focusParagraph = 'unknown';
    sel.focusParagraphOffset = sel.focusOffset;
    return sel;
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

  function hasSelection() {
    return !window.getSelection().isCollapsed;
  }

  function hasSelectionAcrossParagraphs() {
    return hasSelection();
  }
</stream>
