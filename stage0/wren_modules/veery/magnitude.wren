// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
class Magnitude {
  ==(other) {
    return Abort.subclass_responsibility()
  }
  !=(other) {
    return !(this == other)
  }
  <(other) {
    return Abort.subclass_responsibility()
  }
  <=(other) {
    return this < other || this == other
  }
  >(other) {
    return !(this <= other)
  }
  >=(other) {
    return !(this < other)
  }
}
