// DO NOT EDIT: This file is automagically generated

import "veery/compiler/abstract_lang/ast" for Expr
class ThisModuleExpr is Expr {
  construct new(keyword) {
    _keyword = keyword
  }
  keyword{
    return _keyword
  }
  accept(visitor, visitor_data) {
    return visitor.visitThisModuleExpr(this, visitor_data)
  }
  toString{
    return "ThisModule(%(_keyword))"
  }
}
