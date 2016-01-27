<paragraph oninput={ onInput }>
  <span name='content'>{ text }</span>

  this.text = opts.paragraph.get('text');

  onInput(event) {
    // If we got all the way down here, then the browser has probably changed
    // the content and we have to take it out and pass it to the model
    console.trace('onInput:', event);
    this.text.setText(this.displayedText());
  }

  displayedText() {
    return this.content.innerText;
  }
</paragraph>
