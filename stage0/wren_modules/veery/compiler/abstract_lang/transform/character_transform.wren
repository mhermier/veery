// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for CallExpr, ImportStmt, NumExpr
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
class CharacterTransform is TransformVisitor {
  construct new() {
  }
  visitModule(node, visitor_data) {
    node = super(node, visitor_data)
    if (_shouldImport) {
      var importNode = ImportStmt.new("veery/character", ["Character"])
    }
    return node
  }
  visitCharacterExpr(node, visitor_data) {
    _shouldImport = true
    node = super(node, visitor_data)
    var newNode = CallExpr.new(CallExpr.new(null, "Character", null, null), "fromCodePoint", [NumExpr.new(node.nativeValue.codePoint)], null)
    return newNode
  }
}
