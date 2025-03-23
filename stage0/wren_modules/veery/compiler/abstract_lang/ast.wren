// DO NOT EDIT: This file is automagically generated

class Node {
}
class Expr is Node {
}
class Stmt is Node {
}
class Module is Node {
  construct new(interpreter_arguments, statements) {
    _interpreter_arguments = interpreter_arguments
    _statements = statements
  }
  interpreter_arguments{
    return _interpreter_arguments
  }
  statements{
    return _statements
  }
  accept(visitor, visitor_data) {
    return visitor.visitModule(this, visitor_data)
  }
  toString{
    return "Module(%(_interpreter_arguments), %(_statements))"
  }
}
class MapEntryNode {
  construct new(key, value) {
    _key = key
    _value = value
  }
  key{
    return _key
  }
  value{
    return _value
  }
  accept(visitor, visitor_data) {
    return visitor.visitMapEntry(this, visitor_data)
  }
  toString{
    return "%(_key): %(_value)"
  }
}
class Method {
  construct new(attribute_specifiers, foreignKeyword, staticKeyword, constructKeyword, name, subscriptParameters, setter, parenthesisParameters, body) {
    _attribute_specifiers = attribute_specifiers
    _foreignKeyword = foreignKeyword
    _staticKeyword = staticKeyword
    _constructKeyword = constructKeyword
    _name = name
    _subscriptParameters = subscriptParameters
    _setter = setter
    _parenthesisParameters = parenthesisParameters
    _body = body
  }
  attribute_specifiers{
    return _attribute_specifiers
  }
  foreignKeyword{
    return _foreignKeyword
  }
  staticKeyword{
    return _staticKeyword
  }
  constructKeyword{
    return _constructKeyword
  }
  name{
    return _name
  }
  subscriptParameters{
    return _subscriptParameters
  }
  setter{
    return _setter
  }
  parenthesisParameters{
    return _parenthesisParameters
  }
  body{
    return _body
  }
  accept(visitor, visitor_data) {
    return visitor.visitMethod(this, visitor_data)
  }
  toString{
    return "Method(%(_attribute_specifiers) %(_staticKeyword) %(_constructKeyword) %(_name) %(_body))"
  }
}
class Body {
  construct new(parameters, statements) {
    _parameters = parameters
    _statements = statements
  }
  parameters{
    return _parameters
  }
  statements{
    return _statements
  }
  accept(visitor, visitor_data) {
    return visitor.visitBody(this, visitor_data)
  }
  toString{
    return "Body(%(_parameters) %(_statements))"
  }
}
class ListExpr is Expr {
  construct new(leftBracket, elements, rightBracket) {
    _leftBracket = leftBracket
    _elements = elements
    _rightBracket = rightBracket
  }
  leftBracket{
    return _leftBracket
  }
  elements{
    return _elements
  }
  rightBracket{
    return _rightBracket
  }
  accept(visitor, visitor_data) {
    return visitor.visitListExpr(this, visitor_data)
  }
  toString{
    return "List(%(_leftBracket) %(_elements) %(_rightBracket))"
  }
}
class ThisExpr is Expr {
  construct new(keyword) {
    _keyword = keyword
  }
  keyword{
    return _keyword
  }
  accept(visitor, visitor_data) {
    return visitor.visitThisExpr(this, visitor_data)
  }
  toString{
    return "This(%(_keyword))"
  }
}
class NullExpr is Expr {
  construct new(value) {
    _value = value
  }
  value{
    return _value
  }
  accept(visitor, visitor_data) {
    return visitor.visitNullExpr(this, visitor_data)
  }
  toString{
    return "Null(%(_value))"
  }
}
class StaticFieldExpr is Expr {
  construct new(name) {
    _name = name
  }
  name{
    return _name
  }
  accept(visitor, visitor_data) {
    return visitor.visitStaticFieldExpr(this, visitor_data)
  }
  toString{
    return "StaticField(%(_name))"
  }
}
class FieldExpr is Expr {
  construct new(name) {
    _name = name
  }
  name{
    return _name
  }
  accept(visitor, visitor_data) {
    return visitor.visitFieldExpr(this, visitor_data)
  }
  toString{
    return "Field(%(_name))"
  }
}
class CallExpr is Expr {
  construct new(receiver, name, arguments, blockArgument) {
    _receiver = receiver
    _name = name
    _arguments = arguments
    _blockArgument = blockArgument
  }
  receiver{
    return _receiver
  }
  name{
    return _name
  }
  arguments{
    return _arguments
  }
  blockArgument{
    return _blockArgument
  }
  accept(visitor, visitor_data) {
    return visitor.visitCallExpr(this, visitor_data)
  }
  toString{
    return "Call(%(_receiver) %(_name) %(_arguments) %(_blockArgument))"
  }
}
class PrefixExpr is Expr {
  construct new(operator, right) {
    _operator = operator
    _right = right
  }
  operator{
    return _operator
  }
  right{
    return _right
  }
  accept(visitor, visitor_data) {
    return visitor.visitPrefixExpr(this, visitor_data)
  }
  toString{
    return "Prefix(%(_operator) %(_right))"
  }
}
class GroupingExpr is Expr {
  construct new(leftParen, expression, rightParen) {
    _leftParen = leftParen
    _expression = expression
    _rightParen = rightParen
  }
  leftParen{
    return _leftParen
  }
  expression{
    return _expression
  }
  rightParen{
    return _rightParen
  }
  accept(visitor, visitor_data) {
    return visitor.visitGroupingExpr(this, visitor_data)
  }
  toString{
    return "Grouping(%(_leftParen) %(_expression) %(_rightParen))"
  }
}
class AssignmentExpr is Expr {
  construct new(target, equal, value) {
    _target = target
    _equal = equal
    _value = value
  }
  target{
    return _target
  }
  equal{
    return _equal
  }
  value{
    return _value
  }
  accept(visitor, visitor_data) {
    return visitor.visitAssignmentExpr(this, visitor_data)
  }
  toString{
    return "Assignment(%(_target) %(_equal) %(_value))"
  }
}
class CharacterExpr is Expr {
  construct new(value, nativeValue) {
    _value = value
    _nativeValue = nativeValue
  }
  value{
    return _value
  }
  nativeValue{
    return _nativeValue
  }
  accept(visitor, visitor_data) {
    return visitor.visitCharacterExpr(this, visitor_data)
  }
  toString{
    return "Character(%(_value) %(_nativeValue))"
  }
}
class InfixExpr is Expr {
  construct new(left, operator, right) {
    _left = left
    _operator = operator
    _right = right
  }
  left{
    return _left
  }
  operator{
    return _operator
  }
  right{
    return _right
  }
  accept(visitor, visitor_data) {
    return visitor.visitInfixExpr(this, visitor_data)
  }
  toString{
    return "Infix(%(_left) %(_operator) %(_right))"
  }
}
class ConditionalExpr is Expr {
  construct new(condition, question, thenBranch, colon, elseBranch) {
    _condition = condition
    _question = question
    _thenBranch = thenBranch
    _colon = colon
    _elseBranch = elseBranch
  }
  condition{
    return _condition
  }
  question{
    return _question
  }
  thenBranch{
    return _thenBranch
  }
  colon{
    return _colon
  }
  elseBranch{
    return _elseBranch
  }
  accept(visitor, visitor_data) {
    return visitor.visitConditionalExpr(this, visitor_data)
  }
  toString{
    return "Conditional(%(_condition) %(_question) %(_thenBranch) %(_colon) %(_elseBranch))"
  }
}
class MapExpr is Expr {
  construct new(leftBrace, entries, rightBrace) {
    _leftBrace = leftBrace
    _entries = entries
    _rightBrace = rightBrace
  }
  leftBrace{
    return _leftBrace
  }
  entries{
    return _entries
  }
  rightBrace{
    return _rightBrace
  }
  accept(visitor, visitor_data) {
    return visitor.visitMapExpr(this, visitor_data)
  }
  toString{
    return "Map(%(_leftBrace) %(_entries) %(_rightBrace))"
  }
}
class NumExpr is Expr {
  construct new(value) {
    _value = value
  }
  value{
    return _value
  }
  accept(visitor, visitor_data) {
    return visitor.visitNumExpr(this, visitor_data)
  }
  toString{
    return "Num(%(_value))"
  }
}
class SuperExpr is Expr {
  construct new(name, arguments, blockArgument) {
    _name = name
    _arguments = arguments
    _blockArgument = blockArgument
  }
  name{
    return _name
  }
  arguments{
    return _arguments
  }
  blockArgument{
    return _blockArgument
  }
  accept(visitor, visitor_data) {
    return visitor.visitSuperExpr(this, visitor_data)
  }
  toString{
    return "Super(%(_name) %(_arguments) %(_blockArgument))"
  }
}
class StringExpr is Expr {
  construct new(value) {
    _value = value
  }
  value{
    return _value
  }
  accept(visitor, visitor_data) {
    return visitor.visitStringExpr(this, visitor_data)
  }
  toString{
    return "String(%(_value))"
  }
}
class SubscriptExpr is Expr {
  construct new(receiver, leftBracket, arguments, rightBracket) {
    _receiver = receiver
    _leftBracket = leftBracket
    _arguments = arguments
    _rightBracket = rightBracket
  }
  receiver{
    return _receiver
  }
  leftBracket{
    return _leftBracket
  }
  arguments{
    return _arguments
  }
  rightBracket{
    return _rightBracket
  }
  accept(visitor, visitor_data) {
    return visitor.visitSubscriptExpr(this, visitor_data)
  }
  toString{
    return "Subscript(%(_receiver) %(_leftBracket) %(_arguments) %(_rightBracket))"
  }
}
class BoolExpr is Expr {
  construct new(value, nativeValue) {
    _value = value
    _nativeValue = nativeValue
  }
  value{
    return _value
  }
  nativeValue{
    return _nativeValue
  }
  accept(visitor, visitor_data) {
    return visitor.visitBoolExpr(this, visitor_data)
  }
  toString{
    return "Bool(%(_value) %(_nativeValue))"
  }
}
class InterpolationExpr is Expr {
  construct new(strings, expressions) {
    _strings = strings
    _expressions = expressions
  }
  strings{
    return _strings
  }
  expressions{
    return _expressions
  }
  accept(visitor, visitor_data) {
    return visitor.visitInterpolationExpr(this, visitor_data)
  }
  toString{
    return "Interpolation(%(_strings) %(_expressions))"
  }
}
class ForStmt is Stmt {
  construct new(variable, iterator, body) {
    _variable = variable
    _iterator = iterator
    _body = body
  }
  variable{
    return _variable
  }
  iterator{
    return _iterator
  }
  body{
    return _body
  }
  accept(visitor, visitor_data) {
    return visitor.visitForStmt(this, visitor_data)
  }
  toString{
    return "For(%(_variable) %(_iterator) %(_body))"
  }
}
class ReturnStmt is Stmt {
  construct new(keyword, value) {
    _keyword = keyword
    _value = value
  }
  keyword{
    return _keyword
  }
  value{
    return _value
  }
  accept(visitor, visitor_data) {
    return visitor.visitReturnStmt(this, visitor_data)
  }
  toString{
    return "Return(%(_keyword) %(_value))"
  }
}
class BlockStmt is Stmt {
  construct new(statements) {
    _statements = statements
  }
  statements{
    return _statements
  }
  accept(visitor, visitor_data) {
    return visitor.visitBlockStmt(this, visitor_data)
  }
  toString{
    return "Block(%(_statements))"
  }
}
class VarStmt is Stmt {
  construct new(name, initializer) {
    _name = name
    _initializer = initializer
  }
  name{
    return _name
  }
  initializer{
    return _initializer
  }
  accept(visitor, visitor_data) {
    return visitor.visitVarStmt(this, visitor_data)
  }
  toString{
    return "Var(%(_name) %(_initializer))"
  }
}
class ContinueStmt is Stmt {
  construct new(keyword) {
    _keyword = keyword
  }
  keyword{
    return _keyword
  }
  accept(visitor, visitor_data) {
    return visitor.visitContinueStmt(this, visitor_data)
  }
  toString{
    return "Continue(%(_keyword))"
  }
}
class ImportStmt is Stmt {
  construct new(path, variables) {
    _path = path
    _variables = variables
  }
  path{
    return _path
  }
  variables{
    return _variables
  }
  accept(visitor, visitor_data) {
    return visitor.visitImportStmt(this, visitor_data)
  }
  toString{
    return "Import(%(_path) %(_variables))"
  }
}
class IfStmt is Stmt {
  construct new(condition, thenBranch, elseBranch) {
    _condition = condition
    _thenBranch = thenBranch
    _elseBranch = elseBranch
  }
  condition{
    return _condition
  }
  thenBranch{
    return _thenBranch
  }
  elseBranch{
    return _elseBranch
  }
  accept(visitor, visitor_data) {
    return visitor.visitIfStmt(this, visitor_data)
  }
  toString{
    return "If(%(_condition) %(_thenBranch) %(_elseBranch))"
  }
}
class BreakStmt is Stmt {
  construct new(keyword) {
    _keyword = keyword
  }
  keyword{
    return _keyword
  }
  accept(visitor, visitor_data) {
    return visitor.visitBreakStmt(this, visitor_data)
  }
  toString{
    return "Break(%(_keyword))"
  }
}
class WhileStmt is Stmt {
  construct new(condition, body) {
    _condition = condition
    _body = body
  }
  condition{
    return _condition
  }
  body{
    return _body
  }
  accept(visitor, visitor_data) {
    return visitor.visitWhileStmt(this, visitor_data)
  }
  toString{
    return "While(%(_condition) %(_body))"
  }
}
class ClassStmt is Stmt {
  construct new(attribute_specifiers, foreignKeyword, name, superclass, methods) {
    _attribute_specifiers = attribute_specifiers
    _foreignKeyword = foreignKeyword
    _name = name
    _superclass = superclass
    _methods = methods
  }
  attribute_specifiers{
    return _attribute_specifiers
  }
  foreignKeyword{
    return _foreignKeyword
  }
  name{
    return _name
  }
  superclass{
    return _superclass
  }
  methods{
    return _methods
  }
  accept(visitor, visitor_data) {
    return visitor.visitClassStmt(this, visitor_data)
  }
  toString{
    return "Class(%(_attribute_specifiers) %(_foreignKeyword) %(_name) %(_superclass) %(_methods))"
  }
}
