// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/character" for Character
import "veery/input_output/circular_buffer_reader" for Circular_buffer_reader
class Byte_to_UTF8_reader is Circular_buffer_reader {
  construct new(reader) {
    _reader = reader
  }
  read() {
    var byte = _reader.read()
    if (byte <= 0x7f) {
      return Character.fromCodePoint(byte)
    }
    var code_point
    var remaining_bytes
    if ((byte & 0xe0) == 0xc0) {
      code_point = byte & 0x1f
      remaining_bytes = 1
    } else if ((byte & 0xf0) == 0xe0) {
      code_point = byte & 0x0f
      remaining_bytes = 2
    } else if ((byte & 0xf8) == 0xf0) {
      code_point = byte & 0x07
      remaining_bytes = 3
    } else {
      return -1
    }
    while (remaining_bytes > 0) {
      remaining_bytes = remaining_bytes - 1
      byte = _reader.read()
      if ((byte & 0xc0) != 0x80) {
        Fiber.abort("Invalid following byte %(byte)")
      }
      code_point = code_point << 6 | (byte & 0x3f)
    }
    return Character.fromCodePoint(code_point)
  }
}
