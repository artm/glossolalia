import Base from './base';
import Paragraph from './paragraph';

export default class Stream extends Base {
  title() {
    return this.gobject.get('title').getText();
  }

  paragraphs() {
    return this.wrapList('paragraphs', Paragraph);
  }

  breakParagraph(paragraphIndex, remainderLength, newParaStartIndex) {
    var breaking = this.paragraphs()[paragraphIndex];
    var oldText = breaking.text();
    breaking.setText(oldText.substr(0, remainderLength));
    var newParagraph = this.insertParagraph(paragraphIndex+1, oldText.substr(newParaStartIndex));
  }

  insertParagraph(index, text) {
    var paragraph = Paragraph.create(this.model, text);
    this.gobject.get('paragraphs').insert(index, paragraph);
  }
}
