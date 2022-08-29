// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/assert" for Assert
import "veery/character" for Character
class CharacterString {
  construct new_(characters, toString) {
    _characters = characters
    _toString = toString
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
    if (rhs is Character) Abort.TODO()
    if (rhs is CharacterString) return toString == rhs.toString
    if (rhs is String) return toString == rhs
    Abort.runtime_error("Right hand side must be a character or a character string.")
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
    if (rhs is Character) Abort.TODO()
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
}
