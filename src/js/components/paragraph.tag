<paragraph>

  this.on('update', function() {
    console.trace('p update');
    this.setDisplayedText(this.getText());
    return true;
  });

  getText() {
    return opts.paragraph.text()
  }

  setText(newText) {
    opts.paragraph.setText(newText);
  }

  displayedText() {
    return this.root.innerText;
  }

  setDisplayedText(text) {
    this.root.innerText = text;
  }

  pickUpEdits() {
    this.setText(this.displayedText());
  }
</paragraph>
