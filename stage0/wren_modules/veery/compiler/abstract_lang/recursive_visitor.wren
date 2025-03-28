// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class RecursiveVisitor is AbstractVisitor {
  visitBody(node, visitor_data) {
    for (statement in node.statements) {
      statement.accept(this, visitor_data)
    }
  }
  visitMapEntry(node, visitor_data) {
    node.key.accept(this, visitor_data)
    node.value.accept(this, visitor_data)
  }
  visitMethod(node, visitor_data) {
    if (node.body != null) node.body.accept(this, visitor_data)
  }
  visitModule(node, visitor_data) {
    for (statement in node.statements) {
      statement.accept(this, visitor_data)
    }
  }
  visitAssignmentExpr(node, visitor_data) {
    node.target.accept(this, visitor_data)
    node.value.accept(this, visitor_data)
  }
  visitBoolExpr(node, visitor_data) {
  }
  visitCallExpr(node, visitor_data) {
    if (node.receiver != null) node.receiver.accept(this, visitor_data)
    if (node.arguments != null) {
      for (argument in node.arguments) {
        argument.accept(this, visitor_data)
      }
    }
    if (node.blockArgument != null) node.blockArgument.accept(this, visitor_data)
  }
  visitCharacterExpr(node, visitor_data) {
  }
  visitConditionalExpr(node, visitor_data) {
    node.condition.accept(this, visitor_data)
    node.thenBranch.accept(this, visitor_data)
    node.elseBranch.accept(this, visitor_data)
  }
  visitFieldExpr(node, visitor_data) {
  }
  visitGroupingExpr(node, visitor_data) {
    node.expression.accept(this, visitor_data)
  }
  visitInfixExpr(node, visitor_data) {
    node.left.accept(this, visitor_data)
    node.right.accept(this, visitor_data)
  }
  visitInterpolationExpr(node, visitor_data) {
    for (expression in node.expressions) {
      expression.accept(this, visitor_data)
    }
  }
  visitListExpr(node, visitor_data) {
    for (element in node.elements) {
      element.accept(this, visitor_data)
    }
  }
  visitMapExpr(node, visitor_data) {
    for (entry in node.entries) {
      entry.accept(this, visitor_data)
    }
  }
  visitNullExpr(node, visitor_data) {
  }
  visitNumExpr(node, visitor_data) {
  }
  visitPrefixExpr(node, visitor_data) {
    node.right.accept(this, visitor_data)
  }
  visitStaticFieldExpr(node, visitor_data) {
  }
  visitStringExpr(node, visitor_data) {
  }
  visitSubscriptExpr(node, visitor_data) {
    node.receiver.accept(this, visitor_data)
    for (argument in node.arguments) {
      argument.accept(this, visitor_data)
    }
  }
  visitSuperExpr(node, visitor_data) {
    if (node.arguments != null) {
      for (argument in node.arguments) {
        argument.accept(this, visitor_data)
      }
    }
    if (node.blockArgument != null) node.blockArgument.accept(this, visitor_data)
  }
  visitThisExpr(node, visitor_data) {
  }
  visitThisModuleExpr(node, visitor_data) {
  }
  visitBlockStmt(node, visitor_data) {
    for (statement in node.statements) {
      statement.accept(this, visitor_data)
    }
  }
  visitBreakStmt(node, visitor_data) {
  }
  visitClassStmt(node, visitor_data) {
    for (method in node.methods) {
      method.accept(this, visitor_data)
    }
  }
  visitContinueStmt(node, visitor_data) {
  }
  visitForStmt(node, visitor_data) {
    node.iterator.accept(this, visitor_data)
    node.body.accept(this, visitor_data)
  }
  visitIfStmt(node, visitor_data) {
    node.condition.accept(this, visitor_data)
    node.thenBranch.accept(this, visitor_data)
    if (node.elseBranch != null) node.elseBranch.accept(this, visitor_data)
  }
  visitImportStmt(node, visitor_data) {
  }
  visitReturnStmt(node, visitor_data) {
    if (node.value != null) node.value.accept(this, visitor_data)
  }
  visitVarStmt(node, visitor_data) {
    if (node.initializer != null) node.initializer.accept(this, visitor_data)
  }
  visitWhileStmt(node, visitor_data) {
    node.condition.accept(this, visitor_data)
    node.body.accept(this, visitor_data)
  }
}
