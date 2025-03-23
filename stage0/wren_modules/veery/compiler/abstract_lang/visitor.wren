// DO NOT EDIT: This file is automagically generated

import "veery/abort" for Abort
class AbstractVisitor {
  |(rhs) {
    return ComposedVisitor.new(this, rhs)
  }
  visit(node, visitor_data) {
    return Abort.subclass_responsibility(this.type)
  }
  visitBody(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitMapEntry(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitMethod(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitModule(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitAssignmentExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitBoolExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitCallExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitCharacterExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitConditionalExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitFieldExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitGroupingExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitInfixExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitInterpolationExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitListExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitMapExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitNullExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitNumExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitPrefixExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitStaticFieldExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitStringExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitSubscriptExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitSuperExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitThisExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitThisModuleExpr(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitAttributeSpecifier(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitBlockStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitBreakStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitClassStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitContinueStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitForStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitIfStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitImportStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitReturnStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitVarStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
  visitWhileStmt(node, visitor_data) {
    return this.visit(node, visitor_data)
  }
}
import "veery/compiler/abstract_lang/composed_visitor" for ComposedVisitor
