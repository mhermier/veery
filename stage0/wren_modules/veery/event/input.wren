// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/character" for Character
import "veery/chars" for Chars
import "veery/event/key" for Key
import "veery/input_output/circular_buffer_reader" for Circular_buffer_reader
import "veery/input_output/system_console" for System_console
class Input {
  static init_() {
    __escape_O_code_points = {Character.fromCodePoint(80).codePoint: Key.fromString("F1"), Character.fromCodePoint(81).codePoint: Key.fromString("F2"), Character.fromCodePoint(82).codePoint: Key.fromString("F3"), Character.fromCodePoint(83).codePoint: Key.fromString("F4")}
    __escape_left_braket_code_points = {Character.fromCodePoint(65).codePoint: Key.fromString("Up"), Character.fromCodePoint(66).codePoint: Key.fromString("Down"), Character.fromCodePoint(67).codePoint: Key.fromString("Right"), Character.fromCodePoint(68).codePoint: Key.fromString("Left"), Character.fromCodePoint(70).codePoint: Key.fromString("End"), Character.fromCodePoint(72).codePoint: Key.fromString("Home")}
    __escape_left_braket_key_codes = {}
  }
  static new() {
    return new(System_console.input)
  }
  construct new(reader) {
    _reader = Circular_buffer_reader.new(reader)
  }
  read() {
    var c = read_()
    if (c.codePoint == Chars.escape) {
      c = read_()
      if (c.codePoint == Chars.escape) {
        return Key.fromString("Escape")
      } else if (c == Character.fromCodePoint(79)) {
        return handle_map_(__escape_O_code_points, read_().codePoint)
      } else if (c == Character.fromCodePoint(91)) {
        if (peek_().isDigit) {
          var key_code = null
          var modifier = 1
          var key_code_or_modifier = readNumber_()
          if (peek_() == Character.fromCodePoint(59)) {
            Abort.todo("Handle keycode with modifier")
          }
          if (peek_() == Character.fromCodePoint(126)) {
          }
          Abort.todo("Handle modifier or key code")
        }
        return handle_map_(__escape_left_braket_code_points, read_().codePoint)
      } else {
        Abort.todo("Handle ESC %(c) sequences")
      }
    } else {
      return Key.fromCharacter(c)
    }
  }
  handle_map_(map, code) {
    var key = map[code]
    if (key == null) {
      Abort.todo("Handle code %(code)")
    }
    return key
  }
  read_() {
    return _reader.read()
  }
  peek_() {
    return _reader.peek()
  }
  peek_(n) {
    return _reader.peek(n)
  }
  readNumber_() {
    Abort.todo("read number")
  }
}
Input.init_()
