// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for AssignmentExpr, BlockStmt, Body, BoolExpr, BreakStmt, CallExpr, ClassStmt, ConditionalExpr, ContinueStmt, FieldExpr, ForStmt, GroupingExpr, IfStmt, ImportStmt, InfixExpr, InterpolationExpr, ListExpr, MapEntryNode, MapExpr, Method, Module, NullExpr, NumExpr, PrefixExpr, ReturnStmt, StaticFieldExpr, StringExpr, SubscriptExpr, SuperExpr, ThisExpr, VarStmt, WhileStmt
import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class TransformVisitor is AbstractVisitor {
  construct new() {
  }
  accept_(node) {
    if (node == null) return null
    return node.accept(this)
  }
  acceptAll_(nodes) {
    if (nodes == null) return null
    var newNodes = []
    for (node in nodes) {
      newNodes.add(accept_(node))
    }
    return newNodes
  }
  visitBody(node) {
    var newNode = Body.new(node.parameters, acceptAll_(node.statements))
    return newNode
  }
  visitMapEntry(node) {
    var newNode = MapEntryNode.new(accept_(node.key), accept_(node.value))
    return newNode
  }
  visitMethod(node) {
    var newNode = Method.new(node.foreignKeyword, node.staticKeyword, node.constructKeyword, node.name, node.subscriptParameters, node.setter, node.parenthesisParameters, accept_(node.body))
    return newNode
  }
  visitModule(node) {
    var newNode = Module.new(acceptAll_(node.statements))
    return newNode
  }
  visitAssignmentExpr(node) {
    var newNode = AssignmentExpr.new(accept_(node.target), node.equal, accept_(node.value))
    return newNode
  }
  visitBoolExpr(node) {
    return node
  }
  visitCallExpr(node) {
    var newNode = CallExpr.new(accept_(node.receiver), node.name, acceptAll_(node.arguments), accept_(node.blockArgument))
    return newNode
  }
  visitCharacterExpr(node) {
    return node
  }
  visitConditionalExpr(node) {
    var newNode = ConditionalExpr.new(accept_(node.condition), node.question, accept_(node.thenBranch), node.colon, accept_(node.elseBranch))
    return newNode
  }
  visitFieldExpr(node) {
    return node
  }
  visitGroupingExpr(node) {
    var newNode = GroupingExpr.new(node.leftParen, accept_(node.expression), node.rightParen)
    return newNode
  }
  visitInfixExpr(node) {
    var newNode = InfixExpr.new(accept_(node.left), node.operator, accept_(node.right))
    return newNode
  }
  visitInterpolationExpr(node) {
    var newNode = InterpolationExpr.new(node.strings, acceptAll_(node.expressions))
    return newNode
  }
  visitListExpr(node) {
    var newNode = ListExpr.new(node.leftBracket, acceptAll_(node.elements), node.rightBracket)
    return newNode
  }
  visitMapExpr(node) {
    var newNode = MapExpr.new(node.leftBrace, acceptAll_(node.entries), node.rightBrace)
    return newNode
  }
  visitNullExpr(node) {
    return node
  }
  visitNumExpr(node) {
    return node
  }
  visitPrefixExpr(node) {
    var newNode = PrefixExpr.new(node.operator, accept_(node.right))
    return newNode
  }
  visitStaticFieldExpr(node) {
    return node
  }
  visitStringExpr(node) {
    return node
  }
  visitSubscriptExpr(node) {
    var newNode = SubscriptExpr.new(accept_(node.receiver), node.leftBracket, acceptAll_(node.arguments), node.rightBracket)
    return newNode
  }
  visitSuperExpr(node) {
    var newNode = SuperExpr.new(node.name, acceptAll_(node.arguments), accept_(node.blockArgument))
    return newNode
  }
  visitThisExpr(node) {
    return node
  }
  visitThisModuleExpr(node) {
    return node
  }
  visitBlockStmt(node) {
    var newNode = BlockStmt.new(acceptAll_(node.statements))
    return newNode
  }
  visitBreakStmt(node) {
    return node
  }
  visitClassStmt(node) {
    var newNode = ClassStmt.new(node.foreignKeyword, node.name, node.superclass, acceptAll_(node.methods))
    return newNode
  }
  visitContinueStmt(node) {
    return node
  }
  visitEnumDefinition(node) {
    return node
  }
  visitForStmt(node) {
    var newNode = ForStmt.new(node.variable, accept_(node.iterator), accept_(node.body))
    return newNode
  }
  visitIfStmt(node) {
    var newNode = IfStmt.new(accept_(node.condition), accept_(node.thenBranch), accept_(node.elseBranch))
    return newNode
  }
  visitImportStmt(node) {
    return node
  }
  visitReturnStmt(node) {
    var newNode = ReturnStmt.new(node.keyword, accept_(node.value))
    return newNode
  }
  visitVarStmt(node) {
    var newNode = VarStmt.new(node.name, accept_(node.initializer))
    return newNode
  }
  visitWhileStmt(node) {
    var newNode = WhileStmt.new(accept_(node.condition), accept_(node.body))
    return newNode
  }
}
