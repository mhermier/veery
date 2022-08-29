// DO NOT EDIT: This file is automagically generated

import "io" for Stdin
import "veery/input_output/circular_buffer_reader" for Circular_buffer_reader
class Wren_Stdin_reader_adapter_ {
  construct new_(input) {
    _input = input
    _bufferedBytes = "".bytes
    _index = 0
  }
  read() {
    if (_index >= _bufferedBytes.count) {
      _bufferedBytes = _input.readBytes()
      _index = 0
    }
    if (_index >= _bufferedBytes.count) {
      Fiber.abort("bla")
    }
    var byte = _bufferedBytes[_index]
    _index = _index + 1
    return byte
  }
}
class Wren_Stdin_reader_adapter is Circular_buffer_reader {
  static init_() {
    __instance = new(Stdin)
  }
  static instance{
    return __instance
  }
  construct new(input) {
    super(Wren_Stdin_reader_adapter_.new_(input), 8)
  }
}
Wren_Stdin_reader_adapter.init_()
