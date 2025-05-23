// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for BoolExpr
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
class ConstantFoldingTransform is TransformVisitor {
  construct new() {
  }
  visitIfStmt(node, visitor_data) {
    node = super(node, visitor_data)
    if (node.condition is BoolExpr) {
      if (node.condition.nativeValue) {
        return node.thenBranch
      } else {
      }
    }
    return node
  }
}
