/*
 * a model is a convenience wrapper around a google drive object
 */
export default class Base {
  constructor(googleModel, googleObject) {
    this.model = googleModel;
    this.gobject = googleObject;
    googleObject._wrapper_ = this;
  }

  static wrap(googleModel, googleObject) {
    return googleObject._wrapper_ || new this(googleModel, googleObject);
  }

  wrapList(field, wrapper) {
    return this.gobject.get(field).asArray().map(goog => wrapper.wrap(this.model, goog));
  }
}
