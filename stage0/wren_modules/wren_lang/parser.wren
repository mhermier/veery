// DO NOT EDIT: This file is automagically generated

import "veery/assert" for Assert
import "veery/character" for Character
import "veery/compiler/abstract_lang/ast" for AssignmentExpr, BlockStmt, Body, BoolExpr, BreakStmt, CallExpr, ClassStmt, ConditionalExpr, ContinueStmt, FieldExpr, ForStmt, GroupingExpr, IfStmt, ImportStmt, InfixExpr, InterpolationExpr, ListExpr, MapEntryNode, MapExpr, Method, Module, NullExpr, NumExpr, PrefixExpr, ReturnStmt, StaticFieldExpr, StringExpr, SubscriptExpr, SuperExpr, ThisExpr, VarStmt, WhileStmt
import "veery/compiler/abstract_lang/ast/attribute_specifier" for AttributeSpecifier
import "veery/compiler/abstract_lang/token" for Token, TokenType
import "veery/compiler/reporter" for Severity
import "wren_lang/lexer" for Lexer
var INFIX_OPERATORS = [TokenType.pipePipe, TokenType.ampAmp, TokenType.equalEqual, TokenType.bangEqual, TokenType.isKeyword, TokenType.less, TokenType.lessEqual, TokenType.greater, TokenType.greaterEqual, TokenType.pipe, TokenType.caret, TokenType.amp, TokenType.lessLess, TokenType.greaterGreater, TokenType.dotDot, TokenType.dotDotDot, TokenType.plus, TokenType.minus, TokenType.star, TokenType.slash, TokenType.percent]
class Precedence {
  static NONE{
    return -1
  }
  static LOWEST{
    return 0
  }
  static ASSIGNMENT{
    return 1
  }
  static CONDITIONAL{
    return 2
  }
  static LOGICAL_OR{
    return 3
  }
  static LOGICAL_AND{
    return 4
  }
  static EQUALITY{
    return 5
  }
  static IS{
    return 6
  }
  static COMPARISON{
    return 7
  }
  static BITWISE_OR{
    return 8
  }
  static BITWISE_XOR{
    return 9
  }
  static BITWISE_AND{
    return 10
  }
  static BITWISE_SHIFT{
    return 11
  }
  static RANGE{
    return 12
  }
  static TERM{
    return 13
  }
  static FACTOR{
    return 14
  }
  static UNARY{
    return 15
  }
  static CALL{
    return 16
  }
  static PRIMARY{
    return 17
  }
}
class GrammarRule {
  construct new(prefix, infix, method, precedence, name) {
    _prefix = prefix
    _infix = infix
    _method = method
    _precedence = precedence
    _name = name
  }
  prefix{
    return _prefix
  }
  infix{
    return _infix
  }
  method{
    return _method
  }
  precedence{
    return _precedence
  }
  name{
    return _name
  }
}
class Parser {
  static init_() {
    var unaryOp = Fn.new{|token, parser, canAssign|
      parser.ignoreLine()
      var rhs = parser.parsePrecedence(Precedence.UNARY + 1)
      return PrefixExpr.new(token, rhs)
    }
    var infixOp = Fn.new{|lhs, token, parser, canAssign|
      parser.ignoreLine()
      var rhs = parser.parsePrecedence(Parser.grammar_rule_for_token_type_(token.type).precedence + 1)
      return InfixExpr.new(lhs, token, rhs)
    }
    var assign = Fn.new{|lhs, token, parser, canAssign|
      parser.ignoreLine()
      var rhs = parser.parsePrecedence(Parser.grammar_rule_for_token_type_(token.type).precedence + 1)
      return AssignmentExpr.new(lhs, token, rhs)
    }
    var call = Fn.new{|lhs, token, parser, canAssign|
      parser.ignoreLine()
      var name = parser.consume(TokenType.name, "Expect method name after '.'.")
      return parser.methodCall(lhs, name)
    }
    var subscript = Fn.new{|lhs, token, parser, canAssign|
      var arguments = parser.argumentList()
      var rightBracket = parser.consume(TokenType.rightBracket, "Expect ']' after subscript arguments.")
      return SubscriptExpr.new(lhs, token, arguments, rightBracket)
    }
    var conditional = Fn.new{|lhs, token, parser, canAssign|
      parser.ignoreLine()
      var thenBranch = parser.expression()
      var colon = parser.consume(TokenType.colon, "Expect ':' after then branch of conditional operator.")
      parser.ignoreLine()
      var elseBranch = parser.expression()
      return ConditionalExpr.new(lhs, token, thenBranch, colon, elseBranch)
    }
    var grouping = Fn.new{|token, parser, canAssign|
      return parser.grouping()
    }
    var constructorSignature = Fn.new{|parser, signature|
      return todo()
    }
    var infixSignature = Fn.new{|parser, signature|
      return todo()
    }
    var unarySignature = Fn.new{|parser, signature|
      return todo()
    }
    var mixedSignature = Fn.new{|parser, signature|
      return todo()
    }
    var namedSignature = Fn.new{|parser, signature|
      return todo()
    }
    var subscriptSignature = Fn.new{|parser, signature|
      return todo()
    }
    var UNUSED = GrammarRule.new(null, null, null, Precedence.NONE, null)
    var PREFIX = Fn.new{|fn|
      return GrammarRule.new(fn, null, null, Precedence.NONE, null)
    }
    var INFIX = Fn.new{|prec, fn|
      return GrammarRule.new(null, fn, null, prec, null)
    }
    var INFIX_OPERATOR = Fn.new{|prec, name|
      return GrammarRule.new(null, infixOp, infixSignature, prec, name)
    }
    var PREFIX_OPERATOR = Fn.new{|name|
      return GrammarRule.new(unaryOp, null, unarySignature, Precedence.NONE, name)
    }
    var OPERATOR = Fn.new{|name|
      return GrammarRule.new(unaryOp, infixOp, mixedSignature, Precedence.TERM, name)
    }
    var boolean = Fn.new{|token, parser, canAssign|
      return BoolExpr.new(token, token == TokenType.trueKeyword)
    }
    var list = Fn.new{|token, parser, canAssign|
      return parser.listLiteral()
    }
    var map = Fn.new{|token, parser, canAssign|
      return parser.mapLiteral()
    }
    var name = Fn.new{|token, parser, canAssign|
      return parser.methodCall(null, token)
    }
    var number = Fn.new{|token, parser, canAssign|
      return NumExpr.new(token)
    }
    var null_ = Fn.new{|token, parser, canAssign|
      return NullExpr.new(token)
    }
    var string = Fn.new{|token, parser, canAssign|
      return StringExpr.new(token)
    }
    var stringInterpolation = Fn.new{|token, parser, canAssign|
      return parser.stringInterpolation()
    }
    var field = Fn.new{|token, parser, canAssign|
      return FieldExpr.new(token)
    }
    var super_ = Fn.new{|token, parser, canAssign|
      return parser.superCall()
    }
    var staticField = Fn.new{|token, parser, canAssign|
      return StaticFieldExpr.new(token)
    }
    var this_ = Fn.new{|token, parser, canAssign|
      return ThisExpr.new(token)
    }
    __grammar_rules = {TokenType.numberSign: UNUSED, TokenType.at: UNUSED, TokenType.leftParen: PREFIX.call(grouping), TokenType.rightParen: UNUSED, TokenType.leftBracket: GrammarRule.new(list, subscript, subscriptSignature, Precedence.CALL, null), TokenType.rightBracket: UNUSED, TokenType.leftBrace: PREFIX.call(map), TokenType.rightBrace: UNUSED, TokenType.colon: UNUSED, TokenType.dot: INFIX.call(Precedence.CALL, call), TokenType.dotDot: INFIX_OPERATOR.call(Precedence.RANGE, ".."), TokenType.dotDotDot: INFIX_OPERATOR.call(Precedence.RANGE, "..."), TokenType.comma: UNUSED, TokenType.semicolon: UNUSED, TokenType.star: INFIX_OPERATOR.call(Precedence.FACTOR, "*"), TokenType.slash: INFIX_OPERATOR.call(Precedence.FACTOR, "/"), TokenType.percent: INFIX_OPERATOR.call(Precedence.FACTOR, "\%"), TokenType.hash: UNUSED, TokenType.plus: INFIX_OPERATOR.call(Precedence.TERM, "+"), TokenType.minus: OPERATOR.call("-"), TokenType.lessLess: INFIX_OPERATOR.call(Precedence.BITWISE_SHIFT, "<<"), TokenType.greaterGreater: INFIX_OPERATOR.call(Precedence.BITWISE_SHIFT, ">>"), TokenType.pipe: INFIX_OPERATOR.call(Precedence.BITWISE_OR, "|"), TokenType.pipePipe: INFIX.call(Precedence.LOGICAL_OR, infixOp), TokenType.caret: INFIX_OPERATOR.call(Precedence.BITWISE_XOR, "^"), TokenType.amp: INFIX_OPERATOR.call(Precedence.BITWISE_AND, "&"), TokenType.ampAmp: INFIX.call(Precedence.LOGICAL_AND, infixOp), TokenType.bang: PREFIX_OPERATOR.call("!"), TokenType.tilde: PREFIX_OPERATOR.call("~"), TokenType.question: INFIX.call(Precedence.CONDITIONAL, conditional), TokenType.equal: GrammarRule.new(null, assign, null, Precedence.ASSIGNMENT, null), TokenType.less: INFIX_OPERATOR.call(Precedence.COMPARISON, "<"), TokenType.greater: INFIX_OPERATOR.call(Precedence.COMPARISON, ">"), TokenType.lessEqual: INFIX_OPERATOR.call(Precedence.COMPARISON, "<="), TokenType.greaterEqual: INFIX_OPERATOR.call(Precedence.COMPARISON, ">="), TokenType.equalEqual: INFIX_OPERATOR.call(Precedence.EQUALITY, "=="), TokenType.bangEqual: INFIX_OPERATOR.call(Precedence.EQUALITY, "!="), TokenType.reservedKeyword: UNUSED, TokenType.breakKeyword: UNUSED, TokenType.continueKeyword: UNUSED, TokenType.classKeyword: UNUSED, TokenType.constructKeyword: GrammarRule.new(null, null, constructorSignature, Precedence.NONE, null), TokenType.elseKeyword: UNUSED, TokenType.enumKeyword: UNUSED, TokenType.falseKeyword: PREFIX.call(boolean), TokenType.forKeyword: UNUSED, TokenType.foreignKeyword: UNUSED, TokenType.ifKeyword: UNUSED, TokenType.importKeyword: UNUSED, TokenType.asKeyword: UNUSED, TokenType.inKeyword: UNUSED, TokenType.isKeyword: INFIX_OPERATOR.call(Precedence.IS, "is"), TokenType.nullKeyword: PREFIX.call(null_), TokenType.returnKeyword: UNUSED, TokenType.staticKeyword: UNUSED, TokenType.superKeyword: PREFIX.call(super_), TokenType.thisKeyword: PREFIX.call(this_), TokenType.trueKeyword: PREFIX.call(boolean), TokenType.varKeyword: UNUSED, TokenType.whileKeyword: UNUSED, TokenType.field: PREFIX.call(field), TokenType.staticField: PREFIX.call(staticField), TokenType.name: GrammarRule.new(name, null, namedSignature, Precedence.NONE, null), TokenType.number: PREFIX.call(number), TokenType.string: PREFIX.call(string), TokenType.interpolation: PREFIX.call(stringInterpolation), TokenType.line: UNUSED, TokenType.error: UNUSED, TokenType.eof: UNUSED}
  }
  static grammar_rule_for_token_type_(tokenType) {
    var grammar_rule = __grammar_rules[tokenType]
    Assert.call(grammar_rule, "Missing grammar_rule for token type: %(tokenType)")
    return grammar_rule
  }
  construct new(compiler) {
    _compiler = compiler
  }
  compilation_context{
    return _compilation_context_
  }
  parse(compilation_context, source) {
    _compilation_context_ = compilation_context
    _lexer = Lexer.new(source)
    _current = null
    peek()
    return parseModule()
  }
  parseModule() {
    var interpreter_arguments = match(TokenType.interpreter_arguments)
    var statements = definitions(TokenType.eof, "Expect end of input.")
    return Module.new(interpreter_arguments, statements)
  }
  definitions(right, message) {
    var statements = []
    ignoreLine()
    while (!(peek() == right || peek() == TokenType.eof)) {
      statements.add(definition())
      if (peek() == right || peek() == TokenType.eof) break
      consumeLine("Expect newline after statement.")
    }
    consume(right, message)
    return statements
  }
  definition() {
    var attribute_specifiers = this.attribute_specifiers()
    if (match(TokenType.classKeyword)) {
      return finishClass(attribute_specifiers, null)
    }
    if (match(TokenType.foreignKeyword)) {
      var foreignKeyword = _previous
      consume(TokenType.classKeyword, "Expect 'class' after 'foreign'.")
      return finishClass(attribute_specifiers, foreignKeyword)
    }
    if (match(TokenType.importKeyword)) {
      ignoreLine()
      var path = consume(TokenType.string, "Expect import path.")
      var variables
      if (match(TokenType.forKeyword)) {
        ignoreLine()
        variables = []
        while (true) {
          variables.add(consume(TokenType.name, "Expect imported variable name."))
          if (!match(TokenType.comma)) break
          ignoreLine()
        }
      }
      return ImportStmt.new(path, variables)
    }
    if (match(TokenType.varKeyword)) {
      ignoreLine()
      var name = consume(TokenType.name, "Expect variable name.")
      var initializer
      if (match(TokenType.equal)) {
        ignoreLine()
        initializer = expression()
      }
      return VarStmt.new(name, initializer)
    }
    return statement()
  }
  attribute_specifiers() {
    var attribute_specifiers = []
    var numberSign
    while (numberSign = this.match(TokenType.numberSign)) {
      var name = this.consume(TokenType.name, "Expect method name after '#'.")
      var expression = this.methodCall(null, name)
      this.consumeLine("Expect newline after attribute specifier.")
      var attribute_specifier = AttributeSpecifier.new(numberSign, expression)
      attribute_specifiers.add(attribute_specifier)
    }
    return attribute_specifiers
  }
  finishClass(attribute_specifiers, foreignKeyword) {
    var name = consume(TokenType.name, "Expect class name.")
    var superclass
    if (match(TokenType.isKeyword)) {
      superclass = consume(TokenType.name, "Expect name of superclass.")
    }
    var methods = []
    consume(TokenType.leftBrace, "Expect '{' after class name.")
    ignoreLine()
    while (peek() != TokenType.rightBrace && peek() != TokenType.eof) {
      methods.add(method())
      if (peek() == TokenType.rightBrace) break
      consumeLine("Expect newline after definition in class.")
    }
    consume(TokenType.rightBrace, "Expect '}' after class definition.")
    return ClassStmt.new(attribute_specifiers, foreignKeyword, name, superclass, methods)
  }
  method() {
    var attribute_specifiers = this.attribute_specifiers()
    var foreignKeyword
    if (match(TokenType.foreignKeyword)) {
      foreignKeyword = _previous
    }
    var staticKeyword
    if (match(TokenType.staticKeyword)) {
      staticKeyword = _previous
    }
    var constructKeyword
    if (match(TokenType.constructKeyword)) {
      constructKeyword = _previous
    }
    var name
    var subscriptParameters
    var setter
    var parenthesisParameters
    var allowParameters = false
    var allowSetter = false
    if (match(TokenType.leftBracket)) {
      subscriptParameters = parameterList()
      consume(TokenType.rightBracket, "Expect ']' after parameters.")
      allowParameters = false
      allowSetter = true
    } else if (matchAny(INFIX_OPERATORS)) {
      allowParameters = true
      allowSetter = false
    } else if (matchAny([TokenType.bang, TokenType.tilde])) {
      allowParameters = false
      allowSetter = false
    } else {
      consume(TokenType.name, "Expect method name.")
      allowParameters = true
      allowSetter = true
    }
    name = _previous
    if (setter = match(TokenType.equal)) {
      if (!allowSetter) {
        error("Cannot be a setter method.")
      }
    }
    if (match(TokenType.leftParen)) {
      if (!allowParameters && !setter) {
        error("A parameter list is not allowed for this method.")
      }
      ignoreLine()
      if (!match(TokenType.rightParen)) {
        parenthesisParameters = parameterList()
        ignoreLine()
        consume(TokenType.rightParen, "Expect ')' after parameters.")
      } else {
        parenthesisParameters = []
      }
      if (setter && parenthesisParameters.count != 1) {
        error("A setter method must have only one set value")
      }
    }
    var parameters
    var body
    if (foreignKeyword == null) {
      consume(TokenType.leftBrace, "Expect '{' before method body.")
      body = finishBody(parameters)
    }
    return Method.new(attribute_specifiers, foreignKeyword, staticKeyword, constructKeyword, name, subscriptParameters, setter, parenthesisParameters, body)
  }
  statement() {
    if (match(TokenType.breakKeyword)) {
      return BreakStmt.new(_previous)
    }
    if (match(TokenType.continueKeyword)) {
      return ContinueStmt.new(_previous)
    }
    if (match(TokenType.ifKeyword)) {
      consume(TokenType.leftParen, "Expect '(' after 'if'.")
      ignoreLine()
      var condition = expression()
      consume(TokenType.rightParen, "Expect ')' after if condition.")
      var thenBranch = statement()
      var elseBranch
      if (match(TokenType.elseKeyword)) {
        elseBranch = statement()
      }
      return IfStmt.new(condition, thenBranch, elseBranch)
    }
    if (match(TokenType.forKeyword)) {
      consume(TokenType.leftParen, "Expect '(' after 'for'.")
      var variable = consume(TokenType.name, "Expect for loop variable name.")
      consume(TokenType.inKeyword, "Expect 'in' after loop variable.")
      ignoreLine()
      var iterator = expression()
      consume(TokenType.rightParen, "Expect ')' after loop expression.")
      var body = statement()
      return ForStmt.new(variable, iterator, body)
    }
    if (match(TokenType.whileKeyword)) {
      consume(TokenType.leftParen, "Expect '(' after 'while'.")
      ignoreLine()
      var condition = expression()
      consume(TokenType.rightParen, "Expect ')' after while condition.")
      var body = statement()
      return WhileStmt.new(condition, body)
    }
    if (match(TokenType.returnKeyword)) {
      var keyword = _previous
      var value
      if (peek() != TokenType.line) {
        value = expression()
      }
      return ReturnStmt.new(keyword, value)
    }
    if (match(TokenType.leftBrace)) {
      var statements = definitions(TokenType.rightBrace, "Expect '}' after block.")
      return BlockStmt.new(statements)
    }
    return expression()
  }
  finishBody(parameters) {
    if (match(TokenType.rightBrace)) return Body.new(parameters, [])
    if (!matchLine()) {
      var expr = expression()
      ignoreLine()
      consume(TokenType.rightBrace, "Expect '}' at end of block.")
      return Body.new(parameters, [ReturnStmt.new(null, expr)])
    }
    if (match(TokenType.rightBrace)) return Body.new(parameters, [])
    var statements = definitions(TokenType.rightBrace, "Expect '}' after block.")
    return Body.new(parameters, statements)
  }
  methodCall(receiver, name) {
    var arguments = finishCall()
    return CallExpr.new(receiver, name, arguments[0], arguments[1])
  }
  finishCall() {
    var arguments
    if (match(TokenType.leftParen)) {
      ignoreLine()
      if (match(TokenType.rightParen)) {
        arguments = []
      } else {
        arguments = argumentList()
        consume(TokenType.rightParen, "Expect ')' after arguments.")
      }
    }
    var blockArgument
    if (match(TokenType.leftBrace)) {
      var parameters
      if (match(TokenType.pipe)) {
        parameters = parameterList()
        consume(TokenType.pipe, "Expect '|' after block parameters.")
      }
      blockArgument = finishBody(parameters)
    }
    return [arguments, blockArgument]
  }
  argumentList() {
    var arguments = []
    while (true) {
      ignoreLine()
      arguments.add(expression())
      ignoreLine()
      if (!match(TokenType.comma)) break
    }
    return arguments
  }
  parameterList() {
    var parameters = []
    while (true) {
      ignoreLine()
      parameters.add(consume(TokenType.name, "Expect parameter name."))
      ignoreLine()
      if (!match(TokenType.comma)) break
    }
    return parameters
  }
  grouping() {
    var leftParen = _previous
    var expr = expression()
    var rightParen = consume(TokenType.rightParen, "Expect ')' after expression.")
    return GroupingExpr.new(leftParen, expr, rightParen)
  }
  listLiteral() {
    var leftBracket = _previous
    var elements = []
    ignoreLine()
    while (peek() != TokenType.rightBracket) {
      elements.add(expression())
      ignoreLine()
      if (!match(TokenType.comma)) break
      ignoreLine()
    }
    var rightBracket = consume(TokenType.rightBracket, "Expect ']' after list elements.")
    return ListExpr.new(leftBracket, elements, rightBracket)
  }
  mapLiteral() {
    var leftBrace = _previous
    var entries = []
    ignoreLine()
    while (peek() != TokenType.rightBrace) {
      var key = expression()
      consume(TokenType.colon, "Expect ':' after map key.")
      ignoreLine()
      var value = expression()
      entries.add(MapEntryNode.new(key, value))
      ignoreLine()
      if (!match(TokenType.comma)) break
      ignoreLine()
    }
    var rightBrace = consume(TokenType.rightBrace, "Expect '}' after map entries.")
    return MapExpr.new(leftBrace, entries, rightBrace)
  }
  superCall() {
    var name
    if (match(TokenType.dot)) {
      name = consume(TokenType.name, "Expect method name after 'super.'.")
    }
    var arguments = finishCall()
    return SuperExpr.new(name, arguments[0], arguments[1])
  }
  stringInterpolation() {
    var strings = []
    var expressions = []
    while (true) {
      strings.add(_previous)
      ignoreLine()
      expressions.add(expression())
      ignoreLine()
      if (!match(TokenType.interpolation)) break
    }
    strings.add(consume(TokenType.string, "Expect end of string interpolation."))
    return InterpolationExpr.new(strings, expressions)
  }
  parseInfix(tokenTypes, parseOperand) {
    var expr = parseOperand.call()
    while (matchAny(tokenTypes)) {
      var operator = _previous
      ignoreLine()
      var right = parseOperand.call()
      expr = InfixExpr.new(expr, operator, right)
    }
    return expr
  }
  match(type) {
    if (peek() != type) return null
    return consume()
  }
  matchAny(types) {
    for (type in types) {
      var result = match(type)
      if (result) return result
    }
    return null
  }
  matchLine() {
    if (!match(TokenType.line)) return false
    while (match(TokenType.line)) {
    }
    return true
  }
  ignoreLine() {
    return matchLine()
  }
  consumeLine(error) {
    consume(TokenType.line, error)
    ignoreLine()
  }
  consume() {
    peek()
    _previous = _current
    _current = null
    return _previous
  }
  consume(type, message) {
    var token = consume()
    if (token != type) error(message)
    return token
  }
  peek() {
    while (_current == null) {
      _current = _lexer.readToken()
      if (_current == TokenType.comment || _current == TokenType.whitespace) {
        _current = null
      }
    }
    return _current
  }
  report(compilation_context, warning, message) {
    this.report(compilation_context, warning, message, [_current != null? _current : _previous])
  }
  report(compilation_context, warning, message, tokens) {
    compilation_context.report(warning, message, tokens)
  }
  error(message) {
    return this.report(compilation_context, Severity.Error, message)
  }
  warn(message) {
    return this.report(compilation_context, Severity.Warning, message)
  }
  parsePrecedence(precedence) {
    consume()
    var prefix = Parser.grammar_rule_for_token_type_(_previous.type).prefix
    if (prefix == null) {
      error("Expect expression.")
      return NullExpr.new(_previous)
    }
    var canAssign = precedence <= Precedence.CONDITIONAL
    var node = prefix.call(_previous, this, canAssign)
    while (precedence <= Parser.grammar_rule_for_token_type_(peek().type).precedence) {
      consume()
      var infix = Parser.grammar_rule_for_token_type_(_previous.type).infix
      node = infix.call(node, _previous, this, canAssign)
    }
    return node
  }
  expression() {
    return parsePrecedence(Precedence.LOWEST)
  }
}
Parser.init_()
