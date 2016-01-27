import './paragraph.tag'

<stream>
  <h1>{ title }</h1>
  <section contenteditable
    onkeydown={ onKeydown }
    onkeypress={ onKeypress }
    oncut={ onCut }
    onpaste={ onPaste }
    oninput={ onInput } >
    <paragraph each={ paragraphs } paragraph={ this }/>
  </section>

  this.title = opts.stream.get('title').text;
  this.paragraphs = opts.stream.get('paragraphs').asArray();

  onKeydown(event) {
    console.trace('onKeydown:', event);
    if (event.keyIdentifier === 'Enter') {
      console.trace('handle enter (new paragraph)');
    } else if (event.code === 'Delete') {
      console.trace('handle delete (perhaps remove paragraph)');
    } else if (event.code === 'Backspace') {
      console.trace('handle backspace (perhaps remove paragraph)');
    } else {
      return true;
    }
  }

  onKeypress(event) {
    console.trace('onKeypress:', event);
    if (!document.getSelection().isCollapsed) {
      console.trace('handle type-over (perhaps remove paragraphs)');
    } else {
      return true;
    }
  }

  onCut(event) {
    console.trace('onCut:', event);
    console.trace('handle cut (perhaps remove paragraphs)');
  }

  onPaste(event) {
    console.trace('onPaste:', event);
    if (!document.getSelection().isCollapsed) {
      console.trace('handle paste-over (perhaps remove paragraphs)');
    }
    console.trace('handle paste (perhaps remove paragraphs)');
  }

  onInput(event) {
    // should only be allowed to get here if we're ok with
    // getting user input from the DOM
    console.trace('onInput:', event);
    console.trace('synchronize the stream and its DOM');
  }
</stream>


