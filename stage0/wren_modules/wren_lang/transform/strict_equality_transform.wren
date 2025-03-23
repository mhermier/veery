// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for CallExpr, GroupingExpr, PrefixExpr
import "veery/compiler/abstract_lang/token" for Token, TokenType
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
class StrictEqualityTransform is TransformVisitor {
  construct new() {
  }
  visitInfixExpr(node, visitor_data) {
    node = super(node, visitor_data)
    if (node.operator.type != TokenType.strictEquality && node.operator.type != TokenType.strictInequality) return node
    var newNode = CallExpr.new(CallExpr.new(null, "Object", null, null), "same", [node.left, node.right], null)
    if (node.operator.type != TokenType.strictInequality) {
      newNode = GroupingExpr.new(null, PrefixExpr.new("!", newNode), null)
    }
    return newNode
  }
}
