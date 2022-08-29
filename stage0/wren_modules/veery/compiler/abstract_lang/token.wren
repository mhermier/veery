// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/token_type" for TokenType
class Token {
  construct new(source, type, start, length) {
    _source = source
    _type = type
    _start = start
    _length = length
  }
  ==(other) {
    if (other is String) {
      return _type == other
    }
    return Object.same(this, other)
  }
  !=(other) {
    return !(this == other)
  }
  source{
    return _source
  }
  type{
    return _type
  }
  text{
    return _source.substring(_start, _length)
  }
  start{
    return _start
  }
  length{
    return _length
  }
  lineStart{
    return _source.lineAt(_start)
  }
  lineEnd{
    return _source.lineAt(_start + _length)
  }
  columnStart{
    return _source.columnAt(_start)
  }
  columnEnd{
    return _source.columnAt(_start + _length)
  }
  toString{
    return text.toString
  }
}
