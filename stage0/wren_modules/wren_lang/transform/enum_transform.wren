// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for Body, ClassStmt, Method, ReturnStmt, StaticFieldExpr, StringExpr
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
class EnumTransform is TransformVisitor {
  construct new() {
  }
  visitEnumDefinition(node) {
    node = super(node)
    var staticKeyword = "static"
    var methods = []
    for (definition in node.definitions) {
      methods.add(Method.new(null, staticKeyword, null, definition, null, null, null, Body.new(null, [ReturnStmt.new(null, StringExpr.new("\"%(definition.text)\""))])))
    }
    return ClassStmt.new(null, node.name, null, methods)
  }
}
