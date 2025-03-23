// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class ComposedVisitor is AbstractVisitor {
  construct new(lhs, rhs) {
    _lhs = lhs
    _rhs = rhs
  }
  visit(node, visitor_data) {
    return node.accept(_lhs, visitor_data).accept(_rhs, visitor_data)
  }
}
