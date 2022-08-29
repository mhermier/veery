// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/token" for Token, TokenType
var RED = "\x1b[31m"
var CYAN = "\x1b[36m"
var GRAY = "\x1b[30;1m"
var NORMAL = "\x1b[0m"
class Severity {
  static Warning{
    return "Warning"
  }
  static Error{
    return "Error"
  }
}
class JsonReporter {
  construct new() {
  }
  call(severity, message, tokens) {
    var source = tokens[-1].source
    var tokensJson = tokens.map{|token|
      return {"start": token.start, "length": token.length, "lineStart": token.lineStart, "lineEnd": token.lineEnd, "columnStart": token.columnStart, "columnEnd": token.columnEnd}
    }.toList
    var json = {"severity": severity, "path": source.path, "message": message, "tokens": tokensJson}
    var parts = []
    jsonToBuffer(json, parts)
    System.print(parts.join())
  }
  jsonToBuffer(json, parts) {
    if (json is List) {
      parts.add("[")
      var first = true
      for (element in json) {
        if (!first) parts.add(",")
        first = false
        jsonToBuffer(element, parts)
      }
      parts.add("]")
    } else if (json is Map) {
      parts.add("{")
      var first = true
      for (key in json.keys) {
        if (!first) parts.add(",")
        first = false
        jsonToBuffer(key, parts)
        parts.add(":")
        jsonToBuffer(json[key], parts)
      }
      parts.add("}")
    } else if (json is String) {
      parts.add("\"%(json)\"")
    } else {
      parts.add(json)
    }
  }
}
class PrettyReporter {
  construct new() {
  }
  call(severity, message, tokens) {
    var mainToken = tokens[-1]
    var source = mainToken.source
    System.print("[%(source.path) %(mainToken.lineStart):%(mainToken.columnStart)] " + "%(RED)%(severity):%(NORMAL) %(message)")
    var lineWidth = 0
    for (token in tokens) {
      var width = token.lineEnd.toString.count
      if (width > lineWidth) lineWidth = width
    }
    for (token in tokens) {
      var color = token == mainToken? RED : CYAN
      var end = token == mainToken? "^" : "."
      var mid = token == mainToken? "-" : "."
      var line = source.getLine(token.lineStart)
      var lineNum = "%(GRAY)%(padLeft_(token.lineStart, lineWidth)):%(NORMAL) "
      var indent = padLeft_(" ", lineWidth + 2)
      if (token == TokenType.line) {
        System.print("%(lineNum)%(line)%(GRAY)\\n%(NORMAL)")
        System.print("%(indent)%(" " * line.count)" + "%(color)%(end)%(end)%(NORMAL)")
      } else {
        System.print("%(lineNum)%(line)")
        var space = " " * (token.columnStart - 1)
        var highlight = end
        var length = token.columnEnd - token.columnStart
        if (length > 1) {
          highlight = end + mid * (length - 2) + end
        }
        System.print("%(indent)%(space)%(color)%(highlight)%(NORMAL)")
      }
    }
  }
  padLeft_(value, width) {
    var result = value.toString
    while (result.count < width) result = " " + result
    return result
  }
}
class Reporter {
  construct new(delegate) {
    _delegate = delegate
    _error_count = 0
  }
  call(severity, message, tokens) {
    if (severity == Severity.Error) {
      _error_count = _error_count + 1
    }
    _delegate.call(severity, message, tokens)
  }
  delegate{
    return _delegate
  }
  has_errors{
    return _error_count > 0
  }
  error_count{
    return _error_count
  }
}
