// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for CallExpr
import "veery/compiler/abstract_lang/ast/this_module_expression" for ThisModuleExpr
import "veery/compiler/abstract_lang/token" for Token, TokenType
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
class ThisModuleTransform is TransformVisitor {
  construct new() {
  }
  visitCallExpr(node) {
    node = super(node)
    if (!(node.receiver is ThisModuleExpr)) {
      return node
    }
    return CallExpr.new(null, node.name, node.arguments, node.blockArgument)
  }
}
