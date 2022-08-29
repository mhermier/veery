// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
class ComposedVisitor {
  construct new(lhs, rhs) {
    _lhs = lhs
    _rhs = rhs
  }
  visit_(node) {
    return node.accept(_rhs).accept(_lhs)
  }
  visitBody(node) {
    return visit_(node)
  }
  visitMapEntry(node) {
    return visit_(node)
  }
  visitMethod(node) {
    return visit_(node)
  }
  visitModule(node) {
    return visit_(node)
  }
  visitAssignmentExpr(node) {
    return visit_(node)
  }
  visitBoolExpr(node) {
    return visit_(node)
  }
  visitCallExpr(node) {
    return visit_(node)
  }
  visitCharacterExpr(node) {
    return visit_(node)
  }
  visitConditionalExpr(node) {
    return visit_(node)
  }
  visitFieldExpr(node) {
    return visit_(node)
  }
  visitGroupingExpr(node) {
    return visit_(node)
  }
  visitInfixExpr(node) {
    return visit_(node)
  }
  visitInterpolationExpr(node) {
    return visit_(node)
  }
  visitListExpr(node) {
    return visit_(node)
  }
  visitMapExpr(node) {
    return visit_(node)
  }
  visitNullExpr(node) {
    return visit_(node)
  }
  visitNumExpr(node) {
    return visit_(node)
  }
  visitPrefixExpr(node) {
    return visit_(node)
  }
  visitStaticFieldExpr(node) {
    return visit_(node)
  }
  visitStringExpr(node) {
    return visit_(node)
  }
  visitSubscriptExpr(node) {
    return visit_(node)
  }
  visitSuperExpr(node) {
    return visit_(node)
  }
  visitThisExpr(node) {
    return visit_(node)
  }
  visitThisModuleExpr(node) {
    return visit_(node)
  }
  visitBlockStmt(node) {
    return visit_(node)
  }
  visitBreakStmt(node) {
    return visit_(node)
  }
  visitClassStmt(node) {
    return visit_(node)
  }
  visitContinueStmt(node) {
    return visit_(node)
  }
  visitForStmt(node) {
    return visit_(node)
  }
  visitIfStmt(node) {
    return visit_(node)
  }
  visitImportStmt(node) {
    return visit_(node)
  }
  visitReturnStmt(node) {
    return visit_(node)
  }
  visitVarStmt(node) {
    return visit_(node)
  }
  visitWhileStmt(node) {
    return visit_(node)
  }
}
