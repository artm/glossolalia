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

  hasSelection() {
    return !window.getSelection().isCollapsed;
  }

  hasSelectionAcrossParagraphs() {
    return this.hasSelection();
  }

  onKeydown(event) {
    console.trace(event);
    event.preventUpdate = true;
    if (motion(event)) {
      // allow motion with arrow keys
      return true;
    }
    return false;
  }

  onKeypress(event) {
    console.trace(event);
    event.preventUpdate = true;
    return false;
  }

  onCut(event) {
    console.trace(event);
    event.preventUpdate = true;
    return false;
  }

  onPaste(event) {
    console.trace(event);
    event.preventUpdate = true;
    return false;
  }

  onInput(event) {
    console.trace(event);
    event.preventUpdate = true;
    return false;
  }

  function motion(event) {
    return event.code.startsWith('Arrow') || event.code === 'Home' || event.code === 'End';
  }
</stream>
