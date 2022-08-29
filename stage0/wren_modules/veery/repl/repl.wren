// DO NOT EDIT: This file is automagically generated

import "meta" for Meta
import "io" for Stdin, Stdout
import "os" for Platform
import "ansi/color" for Color
import "veery/compiler/abstract_lang/source_file" for SourceFile
import "veery/compiler/abstract_lang/token" for Token, TokenType
import "veery/character_string" for CharacterString
import "veery/chars" for Chars
import "veery/event/input" for Input
import "veery/event/key" for Key
import "veery/event/loop" for Loop
import "veery/repl/action" for Action
import "veery/repl/actions" for Actions
import "wren_lang/lexer" for Lexer
var TOKEN_COLORS = {TokenType.leftParen: Color.gray, TokenType.rightParen: Color.gray, TokenType.leftBracket: Color.gray, TokenType.rightBracket: Color.gray, TokenType.leftBrace: Color.gray, TokenType.rightBrace: Color.gray, TokenType.colon: Color.gray, TokenType.semicolon: Color.gray, TokenType.dot: Color.gray, TokenType.dotDot: Color.none, TokenType.dotDotDot: Color.none, TokenType.comma: Color.gray, TokenType.star: Color.none, TokenType.slash: Color.none, TokenType.percent: Color.none, TokenType.plus: Color.none, TokenType.minus: Color.none, TokenType.pipe: Color.none, TokenType.pipePipe: Color.none, TokenType.caret: Color.none, TokenType.amp: Color.none, TokenType.ampAmp: Color.none, TokenType.question: Color.none, TokenType.bang: Color.none, TokenType.tilde: Color.none, TokenType.equal: Color.none, TokenType.less: Color.none, TokenType.lessEqual: Color.none, TokenType.lessLess: Color.none, TokenType.greater: Color.none, TokenType.greaterEqual: Color.none, TokenType.greaterGreater: Color.none, TokenType.equalEqual: Color.none, TokenType.bangEqual: Color.none, TokenType.reservedKeyword: Color.red, TokenType.breakKeyword: Color.cyan, TokenType.classKeyword: Color.cyan, TokenType.constructKeyword: Color.cyan, TokenType.elseKeyword: Color.cyan, TokenType.enumKeyword: Color.cyan, TokenType.falseKeyword: Color.cyan, TokenType.forKeyword: Color.cyan, TokenType.foreignKeyword: Color.cyan, TokenType.ifKeyword: Color.cyan, TokenType.importKeyword: Color.cyan, TokenType.inKeyword: Color.cyan, TokenType.isKeyword: Color.cyan, TokenType.nullKeyword: Color.cyan, TokenType.returnKeyword: Color.cyan, TokenType.staticKeyword: Color.cyan, TokenType.superKeyword: Color.cyan, TokenType.thisKeyword: Color.cyan, TokenType.trueKeyword: Color.cyan, TokenType.varKeyword: Color.cyan, TokenType.whileKeyword: Color.cyan, TokenType.field: Color.none, TokenType.staticField: Color.none, TokenType.name: Color.none, TokenType.number: Color.magenta, TokenType.string: Color.yellow, TokenType.interpolation: Color.yellow, TokenType.comment: Color.gray, TokenType.whitespace: Color.none, TokenType.line: Color.none, TokenType.error: Color.red, TokenType.eof: Color.none}
class Repl {
  construct new() {
    _event_loop = Loop.new()
    _input = Input.new()
    _cursor = 0
    _line = CharacterString.fromString("")
    _history = []
    _historyIndex = 0
    _actions = Actions.new([Action.new("Quit").setKeyChord("Ctrl+C").setOnTriggered{
      System.print()
      _event_loop.stop()
    }, Action.new("Delete right or exit").setKeyChord("Ctrl+D").setOnTriggered{
      if (_line.isEmpty) {
        System.print()
        _event_loop.stop()
      }
      deleteRight()
    }, Action.new("Automatic completion").setKeyChord(Chars.tab).setOnTriggered{
      var completion = getCompletion()
      if (completion != null) {
        _line = _line + completion
        _cursor = _line.count
      }
    }, Action.new("Execute input").setKeyChord(Chars.carriageReturn).setOnTriggered{
      executeInput()
    }, Action.new("Clear line").setKeyChord("Ctrl+U").setOnTriggered{
      _line = ""
      cursorBegin()
    }, Action.new("History next").setKeyChord("Ctrl+N").setOnTriggered{
      nextHistory()
    }, Action.new("History previous").setKeyChord("Ctrl+P").setOnTriggered{
      previousHistory()
    }, Action.new("Delete left").setKeyChord(Chars.delete).setOnTriggered{
      deleteLeft()
    }, Action.new("Move cursor left").setKeyChord(Key.left).setOnTriggered{
      cursorLeft()
    }, Action.new("Move cursor right").setKeyChord(Key.right).setOnTriggered{
      cursorRight()
    }, Action.new("History next").setKeyChord(Key.down).setOnTriggered{
      nextHistory()
    }, Action.new("History previous").setKeyChord(Key.up).setOnTriggered{
      previousHistory()
    }, Action.new("Delete right").setKeyChord(Key.delete).setOnTriggered{
      deleteRight()
    }, Action.new("Move cursor at the end of line").setKeyChord("End").setOnTriggered{
      cursorEnd()
    }, Action.new("Move cursor at the begin of line").setKeyChord("Home").setOnTriggered{
      cursorBegin()
    }])
  }
  cursor{
    return _cursor
  }
  cursor=(value) {
    return _cursor = value
  }
  line{
    return _line
  }
  line=(value) {
    return _line = value
  }
  run() {
    Stdin.isRaw = true
    refreshLine(false)
    _event_loop.run()
    while (true) {
      var key = _input.read()
      var byte = key.toKeyCode
      if (_actions.onKeyPressed(byte)) {
      } else if (byte < 0) {
        System.print("Unhandled action key-code [dec]: %(byte)")
      } else {
        handleChar(byte)
      }
      if (!_event_loop.isRuning) break
      refreshLine(true)
    }
  }
  handleChar(byte) {
    if (byte >= Chars.space) {
      insertChar(byte)
    } else if (byte == Chars.ctrlW) {
      while (_cursor != 0 && _line[_cursor - 1] == " ") {
        deleteLeft()
      }
      while (_cursor != 0 && _line[_cursor - 1] != " ") {
        deleteLeft()
      }
    } else {
      System.print("Unhandled key-code [dec]: %(byte)")
    }
  }
  cursorBegin() {
    _cursor = 0
  }
  cursorEnd() {
    _cursor = line.count
  }
  cursorLeft() {
    if (_cursor > 0) _cursor = _cursor - 1
  }
  cursorRight() {
    if (_cursor < line.count) _cursor = _cursor + 1
  }
  insertChar(byte) {
    var char = String.fromCodePoint(byte)
    _line = _line[0 ... _cursor] + char + _line[_cursor .. -1]
    _cursor = _cursor + 1
  }
  deleteLeft() {
    if (_cursor == 0) return
    _line = _line[0 ... (_cursor - 1)] + _line[_cursor .. -1]
    _cursor = _cursor - 1
  }
  deleteRight() {
    if (_cursor == _line.count) return
    _line = _line[0 ... _cursor] + _line[(_cursor + 1) .. -1]
  }
  previousHistory() {
    if (_historyIndex == 0) return
    _historyIndex = _historyIndex - 1
    _line = _history[_historyIndex]
    _cursor = _line.count
  }
  nextHistory() {
    if (_historyIndex >= _history.count) return
    _historyIndex = _historyIndex + 1
    if (_historyIndex < _history.count) {
      _line = _history[_historyIndex]
      _cursor = _line.count
    } else {
      _line = CharacterString.fromString("")
      _cursor = 0
    }
  }
  executeInput() {
    refreshLine(false)
    if (_line != "" && (_history.isEmpty || _history[-1] != _line)) {
      _history.add(_line)
      _historyIndex = _history.count
    }
    var input = _line
    _line = CharacterString.fromString("")
    _cursor = 0
    System.print()
    var token = lexFirst(input)
    if (token == null) return
    var isStatement = token == TokenType.breakKeyword || token == TokenType.classKeyword || token == TokenType.forKeyword || token == TokenType.foreignKeyword || token == TokenType.ifKeyword || token == TokenType.importKeyword || token == TokenType.returnKeyword || token == TokenType.varKeyword || token == TokenType.whileKeyword
    var closure
    if (isStatement) {
      closure = Meta.compile(input.toString)
    } else {
      closure = Meta.compileExpression(input.toString)
    }
    if (closure == null) return
    var fiber = Fiber.new(closure)
    var result = fiber.try()
    if (fiber.error != null) {
      showRuntimeError("Runtime error: %(fiber.error)")
      return
    }
    if (!isStatement) {
      showResult(result)
    }
  }
  lex(line, includeWhitespace) {
    var lexer = Lexer.new(SourceFile.new("<input>", line))
    var tokens = []
    while (true) {
      var token = lexer.readToken()
      if (token == TokenType.eof) break
      if (includeWhitespace || (token.type != TokenType.comment && token.type != TokenType.whitespace)) {
        tokens.add(token)
      }
    }
    return tokens
  }
  lexFirst(line) {
    var lexer = Lexer.new(SourceFile.new("<input>", line))
    while (true) {
      var token = lexer.readToken()
      if (token == TokenType.eof) return null
      if (token.type != TokenType.comment && token.type != TokenType.whitespace) {
        return token
      }
    }
  }
  getCompletion() {
    if (_line.isEmpty) return null
    if (_cursor != _line.count) return null
    for (name in Meta.getModuleVariables("veery/repl/repl")) {
      if (name.startsWith(_line.toString)) {
        return name[_line.count .. -1]
      }
    }
  }
}
class SimpleRepl is Repl {
  construct new() {
    super()
    _erase = ""
  }
  refreshLine(showCompletion) {
    if (line.count > _erase.count) _erase = " " * line.count
    System.write("\r  %(_erase)")
    System.write("\r> ")
    System.write(line)
    Stdout.flush()
  }
  showResult(value) {
    System.print(value)
  }
  showRuntimeError(message) {
    System.print(message)
  }
}
class AnsiRepl is Repl {
  construct new() {
    super()
  }
  handleChar(byte) {
    if (byte == Chars.ctrlA) {
      cursorBegin()
    } else if (byte == Chars.ctrlB) {
      cursorLeft()
    } else if (byte == Chars.ctrlE) {
      cursorEnd()
    } else if (byte == Chars.ctrlF) {
      cursorRight()
    } else if (byte == Chars.ctrlK) {
      line = line[0 ... cursor]
    } else if (byte == Chars.ctrlL) {
      System.write("\x1b[2J")
      System.write("\x1b[H")
    } else {
      return super.handleChar(byte)
    }
    return false
  }
  refreshLine(showCompletion) {
    System.write("\x1b[2K")
    System.write(Color.gray)
    System.write("\r> ")
    System.write(Color.none)
    for (token in lex(line, true)) {
      if (token == TokenType.eof) break
      var color = TOKEN_COLORS[token.type]
      if (color == null) color = Color.none
      System.write(color)
      System.write(token.text)
      System.write(Color.none)
    }
    if (showCompletion) {
      var completion = getCompletion()
      if (completion != null) {
        System.write("%(Color.gray)%(completion)%(Color.none)")
      }
    }
    System.write("\r\x1b[%(2 + cursor)C")
    Stdout.flush()
  }
  showResult(value) {
    System.print("%(Color.brightWhite)%(value)%(Color.none)")
  }
  showRuntimeError(message) {
    System.print("%(Color.red)%(message)%(Color.none)")
  }
}
