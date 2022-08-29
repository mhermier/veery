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
  resolve(node) {
    node.accept(this)
  }
  visitModule(node) {
    super(node)
    _scope.checkForwardReferences()
  }
  visitBody(node) {
    _scope.begin()
    declareVariables(node.parameters)
    super(node)
    _scope.end()
  }
  visitAssignmentExpr(node) {
    var target_type = node.target.type
    if (target_type == AssignmentExpr || target_type == CallExpr || target_type == FieldExpr || target_type == StaticFieldExpr || target_type == SubscriptExpr) {
      return
    }
    _reporter.call(Severity.Error, "Invalid left argument type: %(node.target.type)", [node.equal])
  }
  visitCallExpr(node) {
    if (node.receiver != null) {
      node.receiver.accept(this)
    } else {
      _scope.resolve(node.name)
    }
    if (node.arguments != null) {
      for (argument in node.arguments) {
        argument.accept(this)
      }
    }
    if (node.blockArgument != null) node.blockArgument.accept(this)
  }
  visitBlockStmt(node) {
    _scope.begin()
    super(node)
    _scope.end()
  }
  visitClassStmt(node) {
    _scope.declare(node.name)
    _scope.beginClass()
    super(node)
    _scope.endClass()
  }
  visitForStmt(node) {
    _scope.begin()
    _scope.declare(node.variable)
    super(node)
    _scope.end()
  }
  visitImportStmt(node) {
    declareVariables(node.variables)
    super(node)
  }
  visitVarStmt(node) {
    _scope.declare(node.name)
    super(node)
  }
  declareVariables(variables) {
    if (variables == null) return
    for (variable in variables) {
      _scope.declare(variable)
    }
  }
}
