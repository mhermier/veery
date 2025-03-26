// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/assert" for Assert
import "veery/magnitude" for Magnitude
class Character is Magnitude {
  static init_() {
    if (__enum != null) return
    __enum = {}
    (0 .. 256).each{|codePoint|
      this.fromCodePoint(codePoint)
    }
  }
  construct new_(codePoint, toString) {
    _codePoint = codePoint
    _toString = toString
    __enum[_codePoint] = this
    __enum[_toString] = this
  }
  static new(value) {
    if (value is Character) {
      return this
    }
    if (value is CharacterString) {
      Assert.call(value.count == 1, "invalid argument")
      return value[0]
    }
    if (value is Num) {
      return this.fromCodePoint(value)
    }
    if (value is String) {
      return this.fromString(value)
    }
    Fiber.abort("Value must be a Character, a CharacterString, a String or a Num")
  }
  static fromCodePoint(codePoint) {
    var c = __enum[codePoint]
    if (c != null) return c
    return new_(codePoint, String.fromCodePoint(codePoint))
  }
  static fromString(string) {
    var c = __enum[string]
    if (c != null) return c
    var codePoints = string.codePoints
    Assert.call(codePoints.count == 1, "invalid argument")
    return new_(codePoints[0], string)
  }
  ==(other) {
    return other is Character && _codePoint == other.codePoint
  }
  <(other) {
    return other is Character && _codePoint < other.codePoint
  }
  +(rhs) {
    if (rhs is Character) return CharacterString.fromCharacters([this, rhs])
    if (rhs is CharacterString) return CharacterString.fromCharacters([this] + rhs.characters)
    if (rhs is String) return this + CharacterString.fromString(rhs)
    Abort.runtime_error("Right hand side must be a character or a character string.")
  }
  *(count) {
    return CharacterString.filled(count, this)
  }
  ..(rhs) {
    return CharacterString.fromCharacters((this.codePoint .. rhs.codePoint).map{|codePoint|
      return Character.fromCodePoint(codePoint)
    })
  }
  ...(rhs) {
    return CharacterString.fromCharacters((this.codePoint ... rhs.codePoint).map{|codePoint|
      return Character.fromCodePoint(codePoint)
    })
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
  isPrintable{
    return this >= Character.fromCodePoint(32) && this != Character.fromCodePoint(0x7f)
  }
  isSpace{
    return this == Character.fromCodePoint(9) || this == Character.fromCodePoint(10) || this == Character.fromCodePoint(11) || this == Character.fromCodePoint(12) || this == Character.fromCodePoint(13) || this == Character.fromCodePoint(32)
  }
}
class CharacterString {
  static init_() {
    __wellknown_character_from_escaped = {}
    __wellknown_character_to_escaped = {}
    var add = Fn.new{|code_point, escape_char|
      __wellknown_character_from_escaped[escape_char.codePoint] = Character.new(code_point)
      __wellknown_character_to_escaped[code_point] = Character.fromCodePoint(92) + escape_char
    }
    add.call(0x00, Character.fromCodePoint(48))
    add.call(0x07, Character.fromCodePoint(97))
    add.call(0x08, Character.fromCodePoint(98))
    add.call(0x09, Character.fromCodePoint(116))
    add.call(0x0a, Character.fromCodePoint(110))
    add.call(0x0b, Character.fromCodePoint(118))
    add.call(0x0c, Character.fromCodePoint(102))
    add.call(0x0d, Character.fromCodePoint(114))
    add.call(0x1b, Character.fromCodePoint(101))
    add.call(0x22, Character.fromCodePoint(34))
    add.call(0x25, Character.fromCodePoint(37))
    add.call(0x27, Character.fromCodePoint(39))
    add.call(0x5c, Character.fromCodePoint(92))
  }
  construct new_(characters, toString) {
    _characters = characters
    _toString = toString
  }
  static filled(size, character) {
    return this.fromCharacters(List.filled(size, character))
  }
  static new(value) {
    if (value is CharacterString) {
      return this
    }
    if (value is String) {
      return this.fromString(value)
    }
    Fiber.abort("Value must be a a CharacterString or a String")
  }
  static fromCharacters(characters) {
    return new_(characters.toList, characters.join())
  }
  static fromString(string) {
    Assert.call(string is String, "Argument must be a string")
    var characters = []
    for (codePoint in string.codePoints) {
      characters.add(Character.fromCodePoint(codePoint))
    }
    return new_(characters, string)
  }
  [subscript] {
    if (subscript is Num) return _characters[subscript]
    if (subscript is Range) return CharacterString.fromCharacters(_characters[subscript])
    Abort.runtime_error("Subscript must be a number or a range.")
  }
  ==(rhs) {
    return (rhs is Character || rhs is CharacterString || rhs is String) && toString == rhs.toString
  }
  !=(rhs) {
    return !(this == rhs)
  }
  <(rhs) {
    return Abort.TODO()
  }
  <=(rhs) {
    return Abort.TODO()
  }
  >(rhs) {
    return Abort.TODO()
  }
  >=(rhs) {
    return Abort.TODO()
  }
  +(rhs) {
    if (rhs is Character) return CharacterString.fromCharacters(_characters + [rhs])
    if (rhs is CharacterString) return CharacterString.fromCharacters(_characters + rhs.characters)
    if (rhs is String) return this + CharacterString.fromString(rhs)
    Abort.runtime_error("Right hand side must be a character or a character string.")
  }
  count{
    return _characters.count
  }
  characters{
    return _characters
  }
  isEmpty{
    return _characters.count == 0
  }
  toString{
    return _toString
  }
  iterate(iterator) {
    return _characters.iterate(iterator)
  }
  iteratorValue(iterator) {
    return _characters.iteratorValue(iterator)
  }
  escape{
    var string = CharacterString.new("")
    for (c in this) {
      var escape = __wellknown_character_to_escaped[c.codePoint]
      if (escape != null) {
        string = string + escape
        continue
      }
      if (!c.isPrintable) {
        var escape = Formatter.hex_auto_width(c.codePoint)
        if (escape.count == 2) {
          escape = Character.fromCodePoint(120) + escape
        } else if (escape.count == 4) {
          escape = Character.fromCodePoint(117) + escape
        } else if (escape.count == 8) {
          escape = Character.fromCodePoint(85) + escape
        } else {
          internal_error
        }
        string = string + Character.fromCodePoint(92) + escape
        continue
      }
      string = string + c
    }
    return string
  }
  unescape{
    var string = ""
    var it
    while (it = this.iterate(it)) {
      var c = this.iteratorValue(it)
      if (c == Character.fromCodePoint(92)) {
        it = this.iterate(it)
        c = this.iteratorValue(it)
        var hex_count
        var e = __wellknown_character_from_escaped[c.codePoint]
        if (e) {
          c = e
        } else if (c == Character.fromCodePoint(117)) {
          hex_count = 4
        } else if (c == Character.fromCodePoint(85)) {
          hex_count = 8
        } else if (c == Character.fromCodePoint(120)) {
          hex_count = 2
        } else {
          Fiber.abort("Invalid escape character '%(c)'.")
        }
        if (hex_count) {
          it = it + hex_count + 1
          c = Character.fromCodePoint(Num.fromString("0x" + this[(it - hex_count) ... it].toString))
        }
      }
      string = string + c.toString
    }
    return CharacterString.fromString(string)
  }
}
class Formatter {
  static init_() {
    __hex = CharacterString.new("0123456789abcdef")
  }
  static hex(value) {
    var formatted = CharacterString.new("")
    while (true) {
      formatted = formatted + __hex[value & 0x0f]
      value = value >> 4
      if (value == 0) {
        break
      }
    }
    return formatted
  }
  static hex_auto_width(value) {
    var hex = this.hex(value)
    var hex_width = 2
    if (hex.count > hex_width) {
      hex_width = hex_width << 2
    }
    return Character.fromCodePoint(48) * (hex_width - hex.count) + hex
  }
}
Character.init_()
CharacterString.init_()
Formatter.init_()
