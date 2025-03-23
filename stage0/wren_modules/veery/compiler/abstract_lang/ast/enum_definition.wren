// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for Stmt
class EnumDefinition is Stmt {
  construct new(name, definitions) {
    _name = name
    _definitions = definitions
  }
  name{
    return _name
  }
  definitions{
    return _definitions
  }
  accept(visitor, visitor_data) {
    return visitor.visitEnumDefinition(this, visitor_data)
  }
  toString{
    return "EnumDefinition(%(_name) %(_definitions))"
  }
}
