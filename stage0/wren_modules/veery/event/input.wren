// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/character" for Character
import "veery/event/key" for Key
import "veery/input_output/circular_buffer_reader" for Circular_buffer_reader
import "veery/input_output/system_console" for System_console
class Input {
  static init_() {
    __well_known_codes = {0x01: Key.fromString("Ctrl+A"), 0x02: Key.fromString("Ctrl+B"), 0x03: Key.fromString("Ctrl+C"), 0x04: Key.fromString("Ctrl+D"), 0x05: Key.fromString("Ctrl+E"), 0x06: Key.fromString("Ctrl+F"), 0x07: Key.fromString("Ctrl+G"), 0x08: Key.fromString("Ctrl+H"), 0x09: Key.fromString("Ctrl+I"), 0x0a: Key.fromString("Ctrl+J"), 0x0b: Key.fromString("Ctrl+K"), 0x0c: Key.fromString("Ctrl+L"), 0x0d: Key.fromString("Ctrl+M"), 0x0e: Key.fromString("Ctrl+N"), 0x0f: Key.fromString("Ctrl+O"), 0x10: Key.fromString("Ctrl+P"), 0x11: Key.fromString("Ctrl+Q"), 0x12: Key.fromString("Ctrl+R"), 0x13: Key.fromString("Ctrl+S"), 0x14: Key.fromString("Ctrl+T"), 0x15: Key.fromString("Ctrl+U"), 0x16: Key.fromString("Ctrl+V"), 0x17: Key.fromString("Ctrl+W"), 0x18: Key.fromString("Ctrl+X"), 0x19: Key.fromString("Ctrl+Y"), 0x1a: Key.fromString("Ctrl+Z"), 0x7f: Key.fromString("Backspace")}
    __escape_O_code_points = {Character.fromCodePoint(80).codePoint: Key.fromString("F1"), Character.fromCodePoint(81).codePoint: Key.fromString("F2"), Character.fromCodePoint(82).codePoint: Key.fromString("F3"), Character.fromCodePoint(83).codePoint: Key.fromString("F4")}
    __escape_left_braket_code_points = {Character.fromCodePoint(65).codePoint: Key.fromString("Up"), Character.fromCodePoint(66).codePoint: Key.fromString("Down"), Character.fromCodePoint(67).codePoint: Key.fromString("Right"), Character.fromCodePoint(68).codePoint: Key.fromString("Left"), Character.fromCodePoint(70).codePoint: Key.fromString("End"), Character.fromCodePoint(72).codePoint: Key.fromString("Home")}
    __escape_left_braket_key_codes = {2: Key.fromString("Insert"), 3: Key.fromString("Delete"), 5: Key.fromString("PageUp"), 6: Key.fromString("PageDown"), 15: Key.fromString("F5"), 17: Key.fromString("F6"), 18: Key.fromString("F7"), 19: Key.fromString("F8"), 20: Key.fromString("F9"), 21: Key.fromString("F10"), 23: Key.fromString("F11"), 24: Key.fromString("F12")}
  }
  static new() {
    return new(System_console.input)
  }
  construct new(reader) {
    _reader = Circular_buffer_reader.new(reader)
  }
  read() {
    var c = read_()
    if (c == Character.fromCodePoint(27)) {
      c = read_()
      if (c == Character.fromCodePoint(27)) {
        return Key.fromString("Escape")
      } else if (c == Character.fromCodePoint(79)) {
        return handle_map_(__escape_O_code_points, read_().codePoint)
      } else if (c == Character.fromCodePoint(91)) {
        var key
        var modifier = 1
        if (peek_().isDigit) {
          var key_code_or_modifier = readNumber_()
          if (peek_() == Character.fromCodePoint(59) || peek_() == Character.fromCodePoint(126)) {
            key = __escape_left_braket_key_codes[key_code_or_modifier]
            if (key == null) {
              Abort.todo("Missing key code %(key_code_or_modifier)")
            }
            if (match_(Character.fromCodePoint(59)) && peek_().isDigit) {
              modifier = readNumber_()
            }
            if (!peek_() == Character.fromCodePoint(126)) {
              Abort.todo("~ character expected to close keycode sequence")
            }
          } else {
            modifier = key_code_or_modifier
          }
        }
        if (match_(Character.fromCodePoint(126))) {
          if (key == null) {
            Abort.todo("Missing key code %(code)")
          }
        } else {
          var code = read_()
          key = __escape_left_braket_code_points[code.codePoint]
          if (key == null) {
            Abort.todo("Missing key code %(code)")
          }
        }
        if (modifier != 1) {
          Abort.todo("Handle modifiers")
        }
        return key
      } else {
        Abort.todo("Handle ESC %(c) sequences")
      }
    }
    var key = __well_known_codes[c.codePoint]
    if (key != null) {
      return key
    }
    return Key.fromCharacter(c)
  }
  handle_map_(map, code) {
    var key = map[code]
    if (key == null) {
      Abort.todo("Handle code %(code)")
    }
    return key
  }
  match_(c) {
    if (peek_() != c) return null
    return read_()
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
    var number_string = ""
    while (peek_().isDigit) {
      number_string = number_string + read_().toString
    }
    return Num.fromString(number_string)
  }
}
Input.init_()
