// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/assert" for Assert
import "veery/magnitude" for Magnitude
class Character is Magnitude {
  static init_() {
    if (__enum != null) return
    __enum = {}
    (0 .. 256).each{|codePoint|
      return new_(codePoint)
    }
  }
  static new_(codePoint) {
    return new_(codePoint, String.fromCodePoint(codePoint))
  }
  construct new_(codePoint, toString) {
    _codePoint = codePoint
    _toString = toString
    __enum[_codePoint] = this
    __enum[_toString] = this
  }
  static fromCodePoint(codePoint) {
    var c = __enum[codePoint]
    if (c != null) return c
    return new_(codePoint)
  }
  static fromEscapedString(escapedString) {
    return fromString(unescapeString_(escapedString))
  }
  static fromString(string) {
    var c = __enum[string]
    if (c != null) return c
    var codePoints = string.codePoints
    Assert.call(codePoints.count == 1, "invalid argument")
    var codePoint = codePoints[0]
    return new_(codePoint, string)
  }
  static unescapeString_(escapedString) {
    var string = ""
    var it
    var escapedStringCodePoints = escapedString.codePoints
    while (it = escapedStringCodePoints.iterate(it)) {
      var c = Character.fromCodePoint(escapedStringCodePoints.iteratorValue(it))
      if (c == Character.fromCodePoint(92)) {
        it = escapedStringCodePoints.iterate(it)
        c = Character.fromCodePoint(escapedStringCodePoints.iteratorValue(it))
        if (c == Character.fromCodePoint(92)) {
          c = Character.fromCodePoint(92)
        } else if (c == Character.fromCodePoint(34)) {
          c = Character.fromCodePoint(34)
        } else if (c == Character.fromCodePoint(37)) {
          c = Character.fromCodePoint(37)
        } else if (c == Character.fromCodePoint(39)) {
          c = Character.fromCodePoint(39)
        } else if (c == Character.fromCodePoint(48)) {
          c = Character.fromCodePoint(0)
        } else if (c == Character.fromCodePoint(97)) {
          c = Character.fromCodePoint(97)
        } else if (c == Character.fromCodePoint(98)) {
          c = Character.fromCodePoint(98)
        } else if (c == Character.fromCodePoint(101)) {
          c = Character.fromCodePoint(27)
        } else if (c == Character.fromCodePoint(102)) {
          c = Character.fromCodePoint(12)
        } else if (c == Character.fromCodePoint(110)) {
          c = Character.fromCodePoint(10)
        } else if (c == Character.fromCodePoint(114)) {
          c = Character.fromCodePoint(13)
        } else if (c == Character.fromCodePoint(116)) {
          c = Character.fromCodePoint(9)
        } else if (c == Character.fromCodePoint(118)) {
          c = Character.fromCodePoint(11)
        } else {
          Fiber.abort("Invalid escape character '%(c)'.")
        }
      }
      string = string + c.toString
    }
    return string
  }
  hash{
    return Abort.todo()
  }
  codePoint{
    return _codePoint
  }
  toString{
    return _toString
  }
  ..(other) {
    return Abort.todo()
  }
  ...(other) {
    return Abort.todo()
  }
  isAlpha{
    return isLower || isUpper || this == Character.fromCodePoint(95)
  }
  isDigit{
    return this >= Character.fromCodePoint(48) && this <= Character.fromCodePoint(57)
  }
  isAlphaNumeric{
    return isAlpha || isDigit
  }
  isHexDigit{
    return isDigit || this >= Character.fromCodePoint(97) && this <= Character.fromCodePoint(102) || this >= Character.fromCodePoint(65) && this <= Character.fromCodePoint(70)
  }
  isLower{
    return this >= Character.fromCodePoint(97) && this <= Character.fromCodePoint(122)
  }
  isUpper{
    return this >= Character.fromCodePoint(65) && this <= Character.fromCodePoint(90)
  }
  ==(other) {
    return other is Character && _codePoint == other.codePoint
  }
  <(other) {
    return other is Character && _codePoint < other.codePoint
  }
}
Character.init_()
