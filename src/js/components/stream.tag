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
    return false;
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
