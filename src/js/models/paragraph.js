import Base from './base';

export default class Paragraph extends Base {
  text() {
    return this.gobject.get('text').getText();
  }

  setText(newText) {
    this.gobject.get('text').setText(newText);
  }
}
