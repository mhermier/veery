// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/character" for Character
class Key {
  static init_() {
    __enum = {}
    __automatic_key_code = 0
    for (i in 1 .. 26) Key.new_("Ctrl+%(Character.fromCodePoint(Character.fromCodePoint(64).codePoint + i))", i)
    for (i in 0 .. 20) Key.new_("F%(i)")
    Key.new_("Backspace")
    __delete = Key.new_("Delete")
    __down = Key.new_("Down")
    __end = Key.new_("End")
    Key.new_("Escape")
    __home = Key.new_("Home")
    Key.new_("Insert")
    __left = Key.new_("Left")
    Key.new_("PageDown")
    Key.new_("PageUp")
    __right = Key.new_("Right")
    __up = Key.new_("Up")
  }
  static new_(toString) {
    __automatic_key_code = __automatic_key_code - 1
    return new_(toString, __automatic_key_code)
  }
  construct new_(toString, toKeyCode) {
    _toKeyCode = toKeyCode
    _toString = toString
    __enum[_toKeyCode] = this
    __enum[_toString] = this
  }
  static fromCharacter(c) {
    var codePoint = c.codePoint
    var k = __enum[codePoint]
    if (k != null) return k
    return new_(c.toString, codePoint)
  }
  static fromString(s) {
    var k = __enum[s]
    if (k != null) return k
    Abort.todo("Unknown \"%(s)\" key")
  }
  static delete{
    return __delete
  }
  static down{
    return __down
  }
  static end{
    return __end
  }
  static home{
    return __home
  }
  static left{
    return __left
  }
  static right{
    return __right
  }
  static up{
    return __up
  }
  hash{
    return Abort.todo()
  }
  toKeyCode{
    return _toKeyCode
  }
  toString{
    return _toString
  }
}
Key.init_()
