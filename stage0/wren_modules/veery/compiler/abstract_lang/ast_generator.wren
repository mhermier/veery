// DO NOT EDIT: This file is automagically generated

import "io" for File
var EXPRS = {"Assignment": ["target", "equal", "value"], "Bool": ["value", "nativeValue"], "Character": ["value", "nativeValue"], "Call": ["receiver", "name", "arguments", "blockArgument"], "Conditional": ["condition", "question", "thenBranch", "colon", "elseBranch"], "Field": ["name"], "Grouping": ["leftParen", "expression", "rightParen"], "Infix": ["left", "operator", "right"], "Interpolation": ["strings", "expressions"], "List": ["leftBracket", "elements", "rightBracket"], "Map": ["leftBrace", "entries", "rightBrace"], "Null": ["value"], "Num": ["value"], "Prefix": ["operator", "right"], "StaticField": ["name"], "String": ["value"], "Subscript": ["receiver", "leftBracket", "arguments", "rightBracket"], "Super": ["name", "arguments", "blockArgument"], "This": ["keyword"], "ThisModule": ["keyword"]}
var STMTS = {"Block": ["statements"], "Break": ["keyword"], "Class": ["foreignKeyword", "name", "superclass", "methods"], "Continue": ["keyword"], "For": ["variable", "iterator", "body"], "If": ["condition", "thenBranch", "elseBranch"], "Import": ["path", "variables"], "Return": ["keyword", "value"], "While": ["condition", "body"], "Var": ["name", "initializer"]}
class AstBuilder {
  construct new() {
  }
  build() {
    _file = File.create("ast.veery")
    writeLine("class Node {};

class Expr is Node {};

class Stmt is Node {};

class Module is Node {
  construct new(statements) {
    _statements = statements;
  }

  statements { _statements }

  accept(visitor) { visitor.visitModule(this) }

  toString { \"Module(\%(_statements))\" }
}

class MapEntryNode {
  construct new(key, value) {
    _key = key;
    _value = value;
  }

  key { _key }
  value { _value }

  accept(visitor) { visitor.visitMapEntry(this) }

  toString { \"\%(_key): \%(_value)\" }
}

class Method {
  construct new(foreignKeyword, staticKeyword, constructKeyword, name, subscriptParameters, setter, parenthesisParameters, body) {
    _foreignKeyword = foreignKeyword;
    _staticKeyword = staticKeyword;
    _constructKeyword = constructKeyword;
    _name = name;
    _subscriptParameters = subscriptParameters;
    _setter = setter;
    _parenthesisParameters = parenthesisParameters;
    _body = body;
  }

  foreignKeyword        { _foreignKeyword }
  staticKeyword         { _staticKeyword }
  constructKeyword      { _constructKeyword }
  name                  { _name }
  subscriptParameters   { _subscriptParameters }
  setter                { _setter }
  parenthesisParameters { _parenthesisParameters }
  body                  { _body }

  accept(visitor) { visitor.visitMethod(this) }

  toString {
    return \"Method(\%(_staticKeyword) \%(_constructKeyword) \%(_name) \%(_body))\";
  }
}

// A block argument or method body.
class Body {
  construct new(parameters, statements) {
    _parameters = parameters;
    _statements = statements;
  }

  parameters { _parameters }
  statements { _statements }

  accept(visitor) { visitor.visitBody(this) }

  toString {
    return \"Body(\%(_parameters) \%(_statements))\";
  }
}")
    writeClasses(EXPRS, "Expr")
    writeClasses(STMTS, "Stmt")
    _file.close()
  }
  writeClasses(classes, superclass) {
    for (name in classes.keys) {
      var fields = classes[name]
      var params = fields.join(", ")
      writeLine()
      writeLine("class %(name)%(superclass) is %(superclass) {")
      writeLine("  construct new(%(params)) {")
      for (field in fields) {
        writeLine("    _%(field) = %(field)")
      }
      writeLine("  }")
      writeLine()
      for (field in fields) {
        writeLine("  %(field) { _%(field) }")
      }
      writeLine()
      writeLine("  accept(visitor) { visitor.visit%(name)%(superclass)(this) }")
      writeLine()
      writeLine("  toString {")
      var interpolation = fields.map{|field|
        return "\%(_%(field))"
      }.join(" ")
      writeLine("    return \"%(name)(%(interpolation))\"")
      writeLine("  }")
      writeLine("}")
    }
  }
  writeLine() {
    _file.writeBytes("\n")
  }
  writeLine(line) {
    _file.writeBytes(line + "\n")
  }
}
AstBuilder.new().build()
