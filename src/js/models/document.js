import Base from './base';
import Stream from './stream';

export default class Document extends Base {
  streams() {
    return wrapList('streams', Stream);
  }
}
