// DO NOT EDIT: This file is automagically generated

import "veery/assert" for Assert
import "veery/character" for Character
import "veery/character_string" for CharacterString
class SourceFile {
  construct new(path, string) {
    Assert.call(string is CharacterString, "Argument must be a character_string")
    _path = path
    _string = string
  }
  [index] {
    return _string[index]
  }
  count{
    return _string.count
  }
  path{
    return _path
  }
  columnAt(offset) {
    var column = 1
    for (i in (offset - 1) .. 0) {
      if (_string[i] == Character.fromCodePoint(10)) break
      column = column + 1
    }
    return column
  }
  lineAt(offset) {
    var line = 0
    findLines_()
    for (i in 0 ... _lines.count) {
      if (offset < _lines[i]) return i
    }
    return _lines.count
  }
  getLine(line) {
    var newlines = findLines_()
    return _string[newlines[line - 1] ... (newlines[line] - 1)]
  }
  substring(start, length) {
    return _string[start ... (start + length)]
  }
  findLines_() {
    if (_lines != null) return _lines
    _lines = [0]
    for (i in 0 ... _string.count) {
      if (_string[i] == Character.fromCodePoint(10)) _lines.add(i + 1)
    }
    return _lines
  }
}
