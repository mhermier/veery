// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for AssignmentExpr, BlockStmt, Body, BoolExpr, BreakStmt, CallExpr, ClassStmt, ConditionalExpr, ContinueStmt, FieldExpr, ForStmt, GroupingExpr, IfStmt, ImportStmt, InfixExpr, InterpolationExpr, ListExpr, MapEntryNode, MapExpr, Method, Module, NullExpr, NumExpr, PrefixExpr, ReturnStmt, StaticFieldExpr, StringExpr, SubscriptExpr, SuperExpr, ThisExpr, VarStmt, WhileStmt
import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class TransformVisitor is AbstractVisitor {
  construct new() {
  }
  accept_(node, visitor_data) {
    if (node == null) return null
    return node.accept(this, visitor_data)
  }
  acceptAll_(nodes, visitor_data) {
    if (nodes == null) return null
    var newNodes = []
    for (node in nodes) {
      newNodes.add(accept_(node, visitor_data))
    }
    return newNodes
  }
  visitBody(node, visitor_data) {
    var newNode = Body.new(node.parameters, acceptAll_(node.statements, visitor_data))
    return newNode
  }
  visitMapEntry(node, visitor_data) {
    var newNode = MapEntryNode.new(accept_(node.key, visitor_data), accept_(node.value, visitor_data))
    return newNode
  }
  visitMethod(node, visitor_data) {
    var newNode = Method.new(node.attribute_specifiers, node.foreignKeyword, node.staticKeyword, node.constructKeyword, node.name, node.subscriptParameters, node.setter, node.parenthesisParameters, accept_(node.body, visitor_data))
    return newNode
  }
  visitModule(node, visitor_data) {
    var newNode = Module.new(node.interpreter_arguments, acceptAll_(node.statements, visitor_data))
    return newNode
  }
  visitAssignmentExpr(node, visitor_data) {
    var newNode = AssignmentExpr.new(accept_(node.target, visitor_data), node.equal, accept_(node.value, visitor_data))
    return newNode
  }
  visitBoolExpr(node, visitor_data) {
    return node
  }
  visitCallExpr(node, visitor_data) {
    var newNode = CallExpr.new(accept_(node.receiver, visitor_data), node.name, acceptAll_(node.arguments, visitor_data), accept_(node.blockArgument, visitor_data))
    return newNode
  }
  visitCharacterExpr(node, visitor_data) {
    return node
  }
  visitConditionalExpr(node, visitor_data) {
    var newNode = ConditionalExpr.new(accept_(node.condition, visitor_data), node.question, accept_(node.thenBranch, visitor_data), node.colon, accept_(node.elseBranch, visitor_data))
    return newNode
  }
  visitFieldExpr(node, visitor_data) {
    return node
  }
  visitGroupingExpr(node, visitor_data) {
    var newNode = GroupingExpr.new(node.leftParen, accept_(node.expression, visitor_data), node.rightParen)
    return newNode
  }
  visitInfixExpr(node, visitor_data) {
    var newNode = InfixExpr.new(accept_(node.left, visitor_data), node.operator, accept_(node.right, visitor_data))
    return newNode
  }
  visitInterpolationExpr(node, visitor_data) {
    var newNode = InterpolationExpr.new(node.strings, acceptAll_(node.expressions, visitor_data))
    return newNode
  }
  visitListExpr(node, visitor_data) {
    var newNode = ListExpr.new(node.leftBracket, acceptAll_(node.elements, visitor_data), node.rightBracket)
    return newNode
  }
  visitMapExpr(node, visitor_data) {
    var newNode = MapExpr.new(node.leftBrace, acceptAll_(node.entries, visitor_data), node.rightBrace)
    return newNode
  }
  visitNullExpr(node, visitor_data) {
    return node
  }
  visitNumExpr(node, visitor_data) {
    return node
  }
  visitPrefixExpr(node, visitor_data) {
    var newNode = PrefixExpr.new(node.operator, accept_(node.right, visitor_data))
    return newNode
  }
  visitStaticFieldExpr(node, visitor_data) {
    return node
  }
  visitStringExpr(node, visitor_data) {
    return node
  }
  visitSubscriptExpr(node, visitor_data) {
    var newNode = SubscriptExpr.new(accept_(node.receiver, visitor_data), node.leftBracket, acceptAll_(node.arguments, visitor_data), node.rightBracket)
    return newNode
  }
  visitSuperExpr(node, visitor_data) {
    var newNode = SuperExpr.new(node.name, acceptAll_(node.arguments, visitor_data), accept_(node.blockArgument, visitor_data))
    return newNode
  }
  visitThisExpr(node, visitor_data) {
    return node
  }
  visitThisModuleExpr(node, visitor_data) {
    return node
  }
  visitAttributeSpecifier(node, visitor_data) {
    return node
  }
  visitBlockStmt(node, visitor_data) {
    var newNode = BlockStmt.new(acceptAll_(node.statements, visitor_data))
    return newNode
  }
  visitBreakStmt(node, visitor_data) {
    return node
  }
  visitClassStmt(node, visitor_data) {
    var newNode = ClassStmt.new(node.attribute_specifiers, node.foreignKeyword, node.name, node.superclass, acceptAll_(node.methods, visitor_data))
    return newNode
  }
  visitContinueStmt(node, visitor_data) {
    return node
  }
  visitEnumDefinition(node, visitor_data) {
    return node
  }
  visitForStmt(node, visitor_data) {
    var newNode = ForStmt.new(node.variable, accept_(node.iterator, visitor_data), accept_(node.body, visitor_data))
    return newNode
  }
  visitIfStmt(node, visitor_data) {
    var newNode = IfStmt.new(accept_(node.condition, visitor_data), accept_(node.thenBranch, visitor_data), accept_(node.elseBranch, visitor_data))
    return newNode
  }
  visitImportStmt(node, visitor_data) {
    return node
  }
  visitReturnStmt(node, visitor_data) {
    var newNode = ReturnStmt.new(node.keyword, accept_(node.value, visitor_data))
    return newNode
  }
  visitVarStmt(node, visitor_data) {
    var newNode = VarStmt.new(node.name, accept_(node.initializer, visitor_data))
    return newNode
  }
  visitWhileStmt(node, visitor_data) {
    var newNode = WhileStmt.new(accept_(node.condition, visitor_data), accept_(node.body, visitor_data))
    return newNode
  }
}
