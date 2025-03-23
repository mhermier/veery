// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
import "veery/character" for Character
import "veery/chars" for Chars
import "veery/compiler/abstract_lang/token" for Token, TokenType
var KEYWORDS = {"break": TokenType.breakKeyword, "class": TokenType.classKeyword, "construct": TokenType.constructKeyword, "continue": TokenType.continueKeyword, "else": TokenType.elseKeyword, "false": TokenType.falseKeyword, "for": TokenType.forKeyword, "foreign": TokenType.foreignKeyword, "if": TokenType.ifKeyword, "import": TokenType.importKeyword, "in": TokenType.inKeyword, "is": TokenType.isKeyword, "null": TokenType.nullKeyword, "return": TokenType.returnKeyword, "static": TokenType.staticKeyword, "super": TokenType.superKeyword, "this": TokenType.thisKeyword, "true": TokenType.trueKeyword, "var": TokenType.varKeyword, "while": TokenType.whileKeyword}
var PUNCTUATORS = {Character.fromCodePoint(10).codePoint: [TokenType.line], Character.fromCodePoint(35).codePoint: [TokenType.numberSign], Character.fromCodePoint(64).codePoint: [TokenType.at], Character.fromCodePoint(40).codePoint: [TokenType.leftParen], Character.fromCodePoint(41).codePoint: [TokenType.rightParen], Character.fromCodePoint(91).codePoint: [TokenType.leftBracket], Character.fromCodePoint(93).codePoint: [TokenType.rightBracket], Character.fromCodePoint(123).codePoint: [TokenType.leftBrace], Character.fromCodePoint(125).codePoint: [TokenType.rightBrace], Character.fromCodePoint(58).codePoint: [TokenType.colon], Character.fromCodePoint(44).codePoint: [TokenType.comma], Character.fromCodePoint(42).codePoint: [TokenType.star], Character.fromCodePoint(47).codePoint: [TokenType.slash], Character.fromCodePoint(37).codePoint: [TokenType.percent], Character.fromCodePoint(43).codePoint: [TokenType.plus], Character.fromCodePoint(45).codePoint: [TokenType.minus], Character.fromCodePoint(126).codePoint: [TokenType.tilde], Character.fromCodePoint(94).codePoint: [TokenType.caret], Character.fromCodePoint(63).codePoint: [TokenType.question], Character.fromCodePoint(124).codePoint: [TokenType.pipe, Character.fromCodePoint(124), TokenType.pipePipe], Character.fromCodePoint(38).codePoint: [TokenType.amp, Character.fromCodePoint(38), TokenType.ampAmp], Character.fromCodePoint(33).codePoint: [TokenType.bang, Character.fromCodePoint(61), TokenType.bangEqual], Character.fromCodePoint(61).codePoint: [TokenType.equal, Character.fromCodePoint(61), TokenType.equalEqual], Character.fromCodePoint(46).codePoint: [TokenType.dot, Character.fromCodePoint(46), TokenType.dotDot, Character.fromCodePoint(46), TokenType.dotDotDot]}
class Lexer {
  construct new(source) {
    _source = source
    _start = 0
    _current = 0
    _interpolations = []
  }
  readToken() {
    _start = _current
    var c = peek()
    if (c == null) return makeToken(TokenType.eof)
    advance()
    var d = c.codePoint
    if (!_interpolations.isEmpty) {
      if (c == Character.fromCodePoint(40)) {
        _interpolations[-1] = _interpolations[-1] + 1
      } else if (c == Character.fromCodePoint(41)) {
        _interpolations[-1] = _interpolations[-1] - 1
        if (_interpolations[-1] == 0) {
          _interpolations.removeAt(-1)
          return readString()
        }
      }
    }
    if (c == Character.fromCodePoint(47)) {
      if (match(Character.fromCodePoint(47))) return readLine(TokenType.comment)
      if (match(Character.fromCodePoint(42))) return readBlockComment()
    }
    if (c == Character.fromCodePoint(35)) {
      if (match(Character.fromCodePoint(33))) return this.readLine(TokenType.interpreter_arguments)
    }
    if (PUNCTUATORS.containsKey(d)) {
      var punctuator = PUNCTUATORS[d]
      var type = punctuator[0]
      var i = 1
      while (i < punctuator.count) {
        if (!match(punctuator[i])) break
        type = punctuator[i + 1]
        i = i + 2
      }
      return makeToken(type)
    }
    if (c == Character.fromCodePoint(60)) {
      if (match(Character.fromCodePoint(60))) return makeToken(TokenType.lessLess)
      if (match(Character.fromCodePoint(61))) return makeToken(TokenType.lessEqual)
      return makeToken(TokenType.less)
    }
    if (c == Character.fromCodePoint(62)) {
      if (match(Character.fromCodePoint(62))) return makeToken(TokenType.greaterGreater)
      if (match(Character.fromCodePoint(61))) return makeToken(TokenType.greaterEqual)
      return makeToken(TokenType.greater)
    }
    if (c == Character.fromCodePoint(95)) return readField()
    if (c == Character.fromCodePoint(34)) return readString()
    if (c == Character.fromCodePoint(48) && peek() == Character.fromCodePoint(120)) return readHexNumber()
    if (Chars.isWhitespace(d)) return readWhitespace()
    if (c.isDigit) return readNumber()
    if (c.isAlpha) return readName()
    return makeToken(TokenType.error)
  }
  readLine(tokenType) {
    while (peek() != Character.fromCodePoint(10) && !isAtEnd) {
      advance()
    }
    return makeToken(tokenType)
  }
  readBlockComment() {
    var nesting = 1
    while (nesting > 0) {
      if (isAtEnd) break
      if (peek() == Character.fromCodePoint(47) && peek(1) == Character.fromCodePoint(42)) {
        advance()
        advance()
        nesting = nesting + 1
      } else if (peek() == Character.fromCodePoint(42) && peek(1) == Character.fromCodePoint(47)) {
        advance()
        advance()
        nesting = nesting - 1
        if (nesting == 0) break
      } else {
        advance()
      }
    }
    return makeToken(TokenType.comment)
  }
  readField() {
    var type = TokenType.field
    if (match(Character.fromCodePoint(95))) type = TokenType.staticField
    while (match{|c|
      return c.isAlphaNumeric
    }) {
    }
    return makeToken(type)
  }
  readString() {
    var type = TokenType.string
    while (!isAtEnd) {
      var c = advance()
      if (c == Character.fromCodePoint(92)) {
        advance()
      } else if (c == Character.fromCodePoint(37)) {
        advance()
        _interpolations.add(1)
        type = TokenType.interpolation
        break
      } else if (c == Character.fromCodePoint(34)) {
        break
      }
    }
    return makeToken(type)
  }
  readHexNumber() {
    advance()
    while (match{|c|
      return c.isHexDigit
    }) {
    }
    return makeToken(TokenType.number)
  }
  readWhitespace() {
    while (match{|c|
      return Chars.isWhitespace(c.codePoint)
    }) {
    }
    return makeToken(TokenType.whitespace)
  }
  readNumber() {
    while (match{|c|
      return c.isDigit
    }) {
    }
    if (peek(0) == Character.fromCodePoint(46) && peek(1) != null && peek(1).isDigit) {
      match(Character.fromCodePoint(46))
      while (match{|c|
        return c.isDigit
      }) {
      }
    }
    if (match(Character.fromCodePoint(101))) {
      if (peek(0) == Character.fromCodePoint(43) || peek(0) == Character.fromCodePoint(45)) {
        advance()
      }
      while (match{|c|
        return c.isDigit
      }) {
      }
    }
    return makeToken(TokenType.number)
  }
  readName() {
    while (match{|c|
      return c.isAlphaNumeric
    }) {
    }
    var text = _source.substring(_start, _current - _start)
    var type = TokenType.name
    if (KEYWORDS.containsKey(text.toString)) {
      type = KEYWORDS[text.toString]
    }
    return Token.new(_source, type, _start, _current - _start)
  }
  isAtEnd{
    return _current >= _source.count
  }
  advance() {
    if (!isAtEnd) {
      _current = _current + 1
      return peek(-1)
    }
    return null
  }
  peek() {
    return peek(0)
  }
  peek(n) {
    if (_current + n >= _source.count) return null
    return _source[_current + n]
  }
  match(condition) {
    var c = peek()
    if (c == null) return false
    if (condition is Character) {
      if (condition != c) return false
    } else if (condition is Fn) {
      if (!condition.call(c)) return false
    } else if (c is Num) {
      if (condition != c.codePoint) return false
    } else {
      Abort.internal_error("Unsupported codition type")
    }
    advance()
    return true
  }
  makeToken(type) {
    return Token.new(_source, type, _start, _current - _start)
  }
}
