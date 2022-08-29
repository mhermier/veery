// DO NOT EDIT: This file is automagically generated

class Node {
}
class Expr is Node {
}
class Stmt is Node {
}
class Module is Node {
  construct new(statements) {
    _statements = statements
  }
  statements{
    return _statements
  }
  accept(visitor) {
    return visitor.visitModule(this)
  }
  toString{
    return "Module(%(_statements))"
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
  accept(visitor) {
    return visitor.visitMapEntry(this)
  }
  toString{
    return "%(_key): %(_value)"
  }
}
class Method {
  construct new(foreignKeyword, staticKeyword, constructKeyword, name, subscriptParameters, setter, parenthesisParameters, body) {
    _foreignKeyword = foreignKeyword
    _staticKeyword = staticKeyword
    _constructKeyword = constructKeyword
    _name = name
    _subscriptParameters = subscriptParameters
    _setter = setter
    _parenthesisParameters = parenthesisParameters
    _body = body
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
  accept(visitor) {
    return visitor.visitMethod(this)
  }
  toString{
    return "Method(%(_staticKeyword) %(_constructKeyword) %(_name) %(_body))"
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
  accept(visitor) {
    return visitor.visitBody(this)
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
  accept(visitor) {
    return visitor.visitListExpr(this)
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
  accept(visitor) {
    return visitor.visitThisExpr(this)
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
  accept(visitor) {
    return visitor.visitNullExpr(this)
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
  accept(visitor) {
    return visitor.visitStaticFieldExpr(this)
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
  accept(visitor) {
    return visitor.visitFieldExpr(this)
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
  accept(visitor) {
    return visitor.visitCallExpr(this)
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
  accept(visitor) {
    return visitor.visitPrefixExpr(this)
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
  accept(visitor) {
    return visitor.visitGroupingExpr(this)
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
  accept(visitor) {
    return visitor.visitAssignmentExpr(this)
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
  accept(visitor) {
    return visitor.visitCharacterExpr(this)
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
  accept(visitor) {
    return visitor.visitInfixExpr(this)
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
  accept(visitor) {
    return visitor.visitConditionalExpr(this)
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
  accept(visitor) {
    return visitor.visitMapExpr(this)
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
  accept(visitor) {
    return visitor.visitNumExpr(this)
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
  accept(visitor) {
    return visitor.visitSuperExpr(this)
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
  accept(visitor) {
    return visitor.visitStringExpr(this)
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
  accept(visitor) {
    return visitor.visitSubscriptExpr(this)
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
  accept(visitor) {
    return visitor.visitBoolExpr(this)
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
  accept(visitor) {
    return visitor.visitInterpolationExpr(this)
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
  accept(visitor) {
    return visitor.visitForStmt(this)
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
  accept(visitor) {
    return visitor.visitReturnStmt(this)
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
  accept(visitor) {
    return visitor.visitBlockStmt(this)
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
  accept(visitor) {
    return visitor.visitVarStmt(this)
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
  accept(visitor) {
    return visitor.visitContinueStmt(this)
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
  accept(visitor) {
    return visitor.visitImportStmt(this)
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
  accept(visitor) {
    return visitor.visitIfStmt(this)
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
  accept(visitor) {
    return visitor.visitBreakStmt(this)
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
  accept(visitor) {
    return visitor.visitWhileStmt(this)
  }
  toString{
    return "While(%(_condition) %(_body))"
  }
}
class ClassStmt is Stmt {
  construct new(foreignKeyword, name, superclass, methods) {
    _foreignKeyword = foreignKeyword
    _name = name
    _superclass = superclass
    _methods = methods
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
  accept(visitor) {
    return visitor.visitClassStmt(this)
  }
  toString{
    return "Class(%(_foreignKeyword) %(_name) %(_superclass) %(_methods))"
  }
}
