<paragraph oninput={ onInput }>
  <span name='content' contenteditable></span>

  this.on('update', function() {
    console.trace('p update');
    this.setDisplayedText(this.getText());
    return true;
  });

  onInput(event) {
    console.trace('p input');
    // If we got all the way down here, then the browser has probably changed
    // the content and we have to take it out and pass it to the model
    this.setText(this.displayedText());
    event.preventUpdate = true;
  }

  textModel() {
    return opts.paragraph.get('text');
  }

  getText() {
    return this.textModel().getText();
  }

  setText(newText) {
    this.textModel().setText(newText);
  }

  displayedText() {
    return this.root.innerText;
  }

  setDisplayedText(text) {
    this.content.innerHTML = text;
  }
</paragraph>
