// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/recursive_visitor" for RecursiveVisitor
class CallReceiverValidator is RecursiveVisitor {
  construct new() {
  }
  visitCallExpr(node, visitor_data) {
    if (node.receiver == null) {
      System.print("Missing receiver at %(node.name.lineStart),%(node.name.columnStart) %(node)")
    }
    super(node, visitor_data)
  }
}
