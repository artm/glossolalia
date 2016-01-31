import Base from './base';
import Paragraph from './paragraph';

export default class Stream extends Base {
  title() {
    return this.gobject.get('title').getText();
  }

  paragraphs() {
    return wrapList('paragraphs', Paragraph);
  }
}
