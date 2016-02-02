import Base from './base';

export default class Paragraph extends Base {
  static create(model, text) {
    var paragraph = model.createMap({
      text: model.createString(text || '')
    });
    return paragraph;
  }

  text() {
    return this.gobject.get('text').getText();
  }

  setText(newText) {
    this.gobject.get('text').setText(newText);
  }
}
