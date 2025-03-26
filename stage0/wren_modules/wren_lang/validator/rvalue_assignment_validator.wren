// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/recursive_visitor" for RecursiveVisitor
import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class IsRValue_ is AbstractVisitor {
  construct new_() {
  }
  call(node) {
    return node.accept(this, null)
  }
  visitExpr(node, visitor_data) {
    return true
  }
  visitAssignmentExpr(node, visitor_data) {
    return this.call(node.target)
  }
  visitCallExpr(node, visitor_data) {
    return node.arguments != null || node.blockArgument != null
  }
  visitFieldExpr(node, visitor_data) {
    return false
  }
  visitStaticFieldExpr(node, visitor_data) {
    return false
  }
  visitSubscriptExpr(node, visitor_data) {
    return false
  }
}
var IsRValue = IsRValue_.new_()
class RValueAssignmentValidator is RecursiveVisitor {
  construct new() {
  }
  visitAssignmentExpr(node, visitor_data) {
    if (IsRValue.call(node)) {
      visitor_data.report(visitor_data.compiler.generic_error, "Cannot assign to an rvalue", [node.equal])
    }
    return super(node, visitor_data)
  }
}
