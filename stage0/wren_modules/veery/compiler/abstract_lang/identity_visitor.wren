// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class IdentityVisitor is AbstractVisitor {
  construct new() {
  }
  |(rhs) {
    if (this.type != IdentityVisitor) {
      return super(rhs)
    }
    return rhs
  }
  visit(node, visitor_data) {
    return node
  }
}
