// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for Node
class AttributeSpecifier is Node {
  construct new(tag, expression) {
    _tag = tag
    _expression = expression
  }
  tag{
    return _tag
  }
  expression{
    return _expression
  }
  accept(visitor, visitor_data) {
    return visitor.visitAttributeSpecifier(this, visitor_data)
  }
  toString{
    return "AttributeSpecifier(%(_expression))"
  }
}
