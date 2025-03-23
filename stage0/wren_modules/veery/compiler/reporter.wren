// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/token" for Token, TokenType
var RED = "\x1b[31m"
var YELLOW = "\x1b[33m"
var CYAN = "\x1b[36m"
var GRAY = "\x1b[30;1m"
var NORMAL = "\x1b[0m"
class Severity {
  static None{
    return "None"
  }
  static Notice{
    return "Notice"
  }
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
  call(warning, message, tokens) {
    var severity = warning.severity
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
  static init_() {
    __severity_color = {Severity.Error: RED, Severity.Notice: CYAN, Severity.Warning: YELLOW}
  }
  construct new() {
  }
  call(warning, message, tokens) {
    var severity = warning.severity
    var mainToken = tokens[-1]
    var source = mainToken.source
    var severity_color = __severity_color[severity]
    System.print("[%(source.path) %(mainToken.lineStart):%(mainToken.columnStart)] " + "%(severity_color)%(severity):%(NORMAL) %(message)")
    var lineWidth = 0
    for (token in tokens) {
      var width = token.lineEnd.toString.count
      if (width > lineWidth) lineWidth = width
    }
    for (token in tokens) {
      var color = token == mainToken? severity_color : CYAN
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
PrettyReporter.init_()
