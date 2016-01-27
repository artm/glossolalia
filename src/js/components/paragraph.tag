<paragraph oninput={ onInput }>
  <span name='content' contenteditable>{ text }</span>

  this.on('update', function() {
    this.text = this.getText();
  });

  onInput(event) {
    // If we got all the way down here, then the browser has probably changed
    // the content and we have to take it out and pass it to the model
    var dt = this.displayedText();
    console.trace('dt', dt);
    this.setText(this.displayedText());
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
    return this.content.innerText;
  }
</paragraph>
