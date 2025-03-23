// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for AssignmentExpr, CallExpr, FieldExpr, StaticFieldExpr, SubscriptExpr
import "veery/compiler/abstract_lang/recursive_visitor" for RecursiveVisitor
import "veery/compiler/reporter" for Severity
import "wren_lang/scope" for Scope
class Resolver is RecursiveVisitor {
  construct new(reporter) {
    _reporter = reporter
    _scope = Scope.new(reporter)
  }
  resolve(node, visitor_data) {
    node.accept(this, visitor_data)
  }
  visitModule(node, visitor_data) {
    super(node, visitor_data)
    _scope.checkForwardReferences()
  }
  visitBody(node, visitor_data) {
    _scope.begin()
    declareVariables(node.parameters)
    super(node, visitor_data)
    _scope.end()
  }
  visitAssignmentExpr(node, visitor_data) {
    var target_type = node.target.type
    if (target_type == AssignmentExpr || target_type == CallExpr || target_type == FieldExpr || target_type == StaticFieldExpr || target_type == SubscriptExpr) {
      return
    }
    _reporter.call(Severity.Error, "Invalid left argument type: %(node.target.type)", [node.equal])
  }
  visitCallExpr(node, visitor_data) {
    if (node.receiver != null) {
      node.receiver.accept(this, visitor_data)
    } else {
      _scope.resolve(node.name)
    }
    if (node.arguments != null) {
      for (argument in node.arguments) {
        argument.accept(this, visitor_data)
      }
    }
    if (node.blockArgument != null) node.blockArgument.accept(this, visitor_data)
  }
  visitBlockStmt(node, visitor_data) {
    _scope.begin()
    super(node, visitor_data)
    _scope.end()
  }
  visitClassStmt(node, visitor_data) {
    _scope.declare(node.name)
    _scope.beginClass()
    super(node, visitor_data)
    _scope.endClass()
  }
  visitForStmt(node, visitor_data) {
    _scope.begin()
    _scope.declare(node.variable)
    super(node, visitor_data)
    _scope.end()
  }
  visitImportStmt(node, visitor_data) {
    declareVariables(node.variables)
    super(node, visitor_data)
  }
  visitVarStmt(node, visitor_data) {
    _scope.declare(node.name)
    super(node, visitor_data)
  }
  declareVariables(variables) {
    if (variables == null) return
    for (variable in variables) {
      _scope.declare(variable)
    }
  }
}
