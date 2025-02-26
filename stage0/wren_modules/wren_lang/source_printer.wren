// DO NOT EDIT: This file is automagically generated

import "veery/character" for Character
import "veery/compiler/abstract_lang/visitor" for AbstractVisitor
class SourcePrinter is AbstractVisitor {
  construct new(file) {
    _file = file
    _indent_level = 0
  }
  visitBody(node) {
    write_("{")
    if (node.parameters && node.parameters.count > 0) {
      write_("|")
      writeAll_(node.parameters, ", ")
      write_("|")
    }
    print_()
    printAllNodeIndent_(node.statements)
    write_("}")
  }
  visitMapEntry(node) {
    node.key.accept(this)
    write_(": ")
    node.value.accept(this)
  }
  visitMethod(node) {
    if (node.foreignKeyword) {
      write_("foreign ")
    }
    if (node.staticKeyword) {
      write_("static ")
    }
    if (node.constructKeyword) {
      write_("construct ")
    }
    if (node.name.toString != "]") {
      write_(node.name)
    }
    if (node.subscriptParameters) {
      write_(Character.fromCodePoint(91))
      write_(node.subscriptParameters.join(", "))
      write_("] ")
    }
    if (node.setter) {
      write_(Character.fromCodePoint(61))
    }
    if (node.parenthesisParameters) {
      write_(Character.fromCodePoint(40))
      write_(node.parenthesisParameters.join(", "))
      write_(") ")
    }
    node.body.accept(this)
  }
  visitModule(node) {
    print_("// DO NOT EDIT: This file is automagically generated")
    print_()
    for (statement in node.statements) {
      statement.accept(this)
      print_()
    }
  }
  visitAssignmentExpr(node) {
    node.target.accept(this)
    if (node.value != null) {
      write_(" = ")
      node.value.accept(this)
    }
  }
  visitBoolExpr(node) {
    write_(node.value)
  }
  visitCallExpr(node) {
    if (node.receiver != null) {
      node.receiver.accept(this)
      write_(".")
    }
    write_(node.name)
    if (node.arguments != null) {
      write_("(")
      writeAllNodes_(node.arguments, ", ")
      write_(")")
    }
    if (node.blockArgument != null) {
      node.blockArgument.accept(this)
    }
  }
  visitCharacterExpr(node) {
    Fiber.abort("Character litteral are not supported")
  }
  visitConditionalExpr(node) {
    node.condition.accept(this)
    write_("? ")
    node.thenBranch.accept(this)
    write_(" : ")
    node.elseBranch.accept(this)
  }
  visitFieldExpr(node) {
    write_(node.name)
  }
  visitGroupingExpr(node) {
    write_("(")
    node.expression.accept(this)
    write_(")")
  }
  visitInfixExpr(node) {
    node.left.accept(this)
    write_(" ")
    write_(node.operator)
    write_(" ")
    node.right.accept(this)
  }
  visitInterpolationExpr(node) {
    var strings = node.strings
    var expressions = node.expressions
    var count = expressions.count
    for (i in 0 ... expressions.count) {
      write_(strings[i])
      expressions[i].accept(this)
    }
    write_(strings[count])
  }
  visitListExpr(node) {
    write_("[")
    writeAllNodes_(node.elements, ", ")
    write_("]")
  }
  visitMapExpr(node) {
    write_("{")
    writeAllNodes_(node.entries, ", ")
    write_("}")
  }
  visitNullExpr(node) {
    write_("null")
  }
  visitNumExpr(node) {
    write_(node.value)
  }
  visitPrefixExpr(node) {
    write_(node.operator)
    node.right.accept(this)
  }
  visitStaticFieldExpr(node) {
    write_(node.name)
  }
  visitStringExpr(node) {
    write_(node.value)
  }
  visitSubscriptExpr(node) {
    node.receiver.accept(this)
    write_("[")
    writeAllNodes_(node.arguments, ", ")
    write_("]")
  }
  visitSuperExpr(node) {
    write_("super")
    if (node.name) {
      write_(".")
      write_(node.name)
    }
    write_("(")
    writeAllNodes_(node.arguments, ", ")
    write_(")")
    if (node.blockArgument) {
      node.blockArgument.accept(this)
    }
  }
  visitThisExpr(node) {
    write_("this")
  }
  visitThisModuleExpr(node) {
    Fiber.abort("this_module's are not supported")
  }
  visitBlockStmt(node) {
    printAllBraced_(node.statements)
  }
  visitBreakStmt(node) {
    write_("break")
  }
  visitClassStmt(node) {
    if (node.foreignKeyword != null) {
      write_("foreign ")
    }
    write_("class ")
    write_(node.name)
    if (node.superclass != null) {
      write_(" is ")
      write_(node.superclass)
    }
    write_(" ")
    printAllBraced_(node.methods)
  }
  visitContinueStmt(node) {
    write_("continue")
  }
  visitEnumDefinition(node) {
    Fiber.abort("enum's are not supported")
  }
  visitForStmt(node) {
    write_("for (")
    write_(node.variable)
    write_(" in ")
    node.iterator.accept(this)
    write_(") ")
    node.body.accept(this)
  }
  visitIfStmt(node) {
    write_("if (")
    node.condition.accept(this)
    write_(") ")
    node.thenBranch.accept(this)
    if (node.elseBranch != null) {
      write_(" else ")
      node.elseBranch.accept(this)
    }
  }
  visitImportStmt(node) {
    write_("import ")
    write_(node.path)
    if (node.variables) {
      write_(" for ")
      write_(node.variables.join(", "))
    }
  }
  visitReturnStmt(node) {
    write_("return")
    if (node.value != null) {
      write_(" ")
      node.value.accept(this)
    }
  }
  visitVarStmt(node) {
    write_("var ")
    write_(node.name)
    if (node.initializer != null) {
      write_(" = ")
      node.initializer.accept(this)
    }
  }
  visitWhileStmt(node) {
    write_("while (")
    node.condition.accept(this)
    write_(") ")
    node.body.accept(this)
  }
  indent_() {
    for (i in 0 ... _indent_level) {
      write_("  ")
    }
  }
  indent_level_dec_() {
    _indent_level = _indent_level - 1
  }
  indent_level_inc_() {
    _indent_level = _indent_level + 1
  }
  print_() {
    write_("\n")
  }
  print_(obj) {
    write_(obj)
    print_()
  }
  printAll_(nodes) {
    for (node in nodes) {
      indent_()
      node.accept(this)
      print_()
    }
  }
  printAllNodeIndent_(nodes) {
    indent_level_inc_()
    printAll_(nodes)
    indent_level_dec_()
    indent_()
  }
  printAllBraced_(nodes) {
    print_("{")
    printAllNodeIndent_(nodes)
    write_("}")
  }
  write_(obj) {
    return _file.writeBytes(obj.toString)
  }
  writeAll_(elements, sep) {
    var first = true
    for (element in elements) {
      if (!first) write_(sep)
      first = false
      write_(element)
    }
  }
  writeAllNodes_(nodes, sep) {
    var first = true
    for (node in nodes) {
      if (!first) write_(sep)
      first = false
      node.accept(this)
    }
  }
}
