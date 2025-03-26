// DO NOT EDIT: This file is automagically generated

import "meta" for Meta
import "io" for Stdin, Stdout
import "os" for Platform
import "ansi/color" for Color
import "veery/compiler/abstract_lang/source_file" for SourceFile
import "veery/compiler/abstract_lang/token" for Token, TokenType
import "veery/character" for Character
import "veery/character_string" for CharacterString
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
    _actions = Actions.new{|actions|
      actions.add_action{|action|
        action.description = "Quit"
        action.on_triggered{
          System.print()
          _event_loop.stop()
        }
        action.add_key_chord("Ctrl+C")
      }
      actions.add_action{|action|
        action.description = "Delete right or exit"
        action.on_triggered{
          if (_line.isEmpty) {
            System.print()
            _event_loop.stop()
          }
          deleteRight()
        }
        action.add_key_chord("Ctrl+D")
      }
      actions.add_action{|action|
        action.description = "Execute input"
        action.on_triggered{
          executeInput()
        }
        action.add_key_chord(Character.fromCodePoint(13))
      }
      actions.add_action{|action|
        action.description = "Delete left"
        action.on_triggered{
          deleteLeft()
        }
        action.add_key_chord("Backspace")
      }
      actions.add_action{|action|
        action.description = "Delete right"
        action.on_triggered{
          deleteRight()
        }
        action.add_key_chord(Key.delete)
      }
      actions.add_action{|action|
        action.description = "Clear line"
        action.on_triggered{
          _line = ""
          cursorBegin()
        }
        action.add_key_chord("Ctrl+U")
      }
      actions.add_action{|action|
        action.description = "Clear line right"
        action.on_triggered{
          _line = _line[0 ... cursor]
        }
        action.add_key_chord("Ctrl+K")
      }
      actions.add_action{|action|
        action.description = "Delete previous word"
        action.on_triggered{
          while (_cursor != 0 && _line[_cursor - 1] == Character.fromCodePoint(32)) {
            deleteLeft()
          }
          while (_cursor != 0 && _line[_cursor - 1] != Character.fromCodePoint(32)) {
            deleteLeft()
          }
        }
        action.add_key_chord("Ctrl+W")
      }
      actions.add_action{|action|
        action.description = "Move cursor left"
        action.on_triggered{
          cursorLeft()
        }
        action.add_key_chord("Ctrl+B")
        action.add_key_chord(Key.left)
      }
      actions.add_action{|action|
        action.description = "Move cursor right"
        action.on_triggered{
          cursorRight()
        }
        action.add_key_chord("Ctrl+F")
        action.add_key_chord(Key.right)
      }
      actions.add_action{|action|
        action.description = "Move cursor at the begin of line"
        action.on_triggered{
          cursorBegin()
        }
        action.add_key_chord("Ctrl+A")
        action.add_key_chord("Home")
      }
      actions.add_action{|action|
        action.description = "Move cursor at the end of line"
        action.on_triggered{
          cursorEnd()
        }
        action.add_key_chord("Ctrl+E")
        action.add_key_chord("End")
      }
      actions.add_action{|action|
        action.description = "History next"
        action.on_triggered{
          nextHistory()
        }
        action.add_key_chord("Ctrl+N")
        action.add_key_chord(Key.down)
      }
      actions.add_action{|action|
        action.description = "History previous"
        action.on_triggered{
          previousHistory()
        }
        action.add_key_chord("Ctrl+P")
        action.add_key_chord(Key.up)
      }
      actions.add_action{|action|
        action.description = "Automatic completion"
        action.on_triggered{
          var completion = getCompletion()
          if (completion != null) {
            _line = _line + completion
            _cursor = _line.count
          }
        }
        action.add_key_chord(Character.fromCodePoint(9))
      }
      actions.add_action{|action|
        action.description = "Clear screen"
        action.on_triggered{
          System.write("\x1b[2J")
          System.write("\x1b[H")
        }
        action.add_key_chord("Ctrl+L")
      }
    }
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
      var key_code = key.toKeyCode
      var character = key_code >= 0? Character.new(key_code) : null
      if (_actions.onKeyPressed(key_code)) {
      } else if (character != null && character.isPrintable) {
        insertChar(character)
      } else {
        System.print("Unhandled key-code [dec]: %(key_code)")
      }
      if (!_event_loop.isRuning) break
      refreshLine(true)
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
  insertChar(character) {
    _line = _line[0 ... _cursor] + character + _line[_cursor .. -1]
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
