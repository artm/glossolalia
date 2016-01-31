<paragraph>

  this.on('update', function() {
    console.trace('p update');
    this.setDisplayedText(this.getText());
    return true;
  });

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
    this.root.innerText = text;
  }
</paragraph>
