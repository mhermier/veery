// DO NOT EDIT: This file is automagically generated

import "io" for Directory, File
import "veery/character_string" for CharacterString
import "veery/compiler/abstract_lang/composed_visitor" for ComposedVisitor
import "veery/compiler/abstract_lang/source_file" for SourceFile
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
import "veery/compiler/reporter" for PrettyReporter, Reporter
import "veery_lang/lexer" for Lexer
import "veery_lang/parser" for Parser
import "veery/compiler/abstract_lang/transform/constant_folding_transform/constant_folding_transform" for ConstantFoldingTransform
import "veery/compiler/abstract_lang/transform/character_transform" for CharacterTransform
import "wren_lang/source_printer" for SourcePrinter
import "wren_lang/transform/enum_transform" for EnumTransform
import "wren_lang/transform/strict_equality_transform" for StrictEqualityTransform
import "wren_lang/transform/this_module_transform" for ThisModuleTransform
import "veery/compiler/abstract_lang/validator/call_receiver_validator" for CallReceiverValidator
class Compiler {
  construct new() {
  }
  parseFile(path) {
    var code = CharacterString.fromString(File.read(path))
    var source = SourceFile.new(path, code)
    var parser = Parser.from_source(source, _reporter)
    var ast = parser.parseModule()
    return ast
  }
  run(arguments) {
    _reporter = Reporter.new(PrettyReporter.new())
    if (arguments.count != 2) {
      System.print("Usage: veery-c <source file> <output file>")
      return 1
    }
    var path = arguments[0]
    var ast = parseFile(path)
    if (false) {
      var nullTransformedAST = ast.accept(TransformVisitor.new())
      System.print("NullTransform equality check: %(ast == nullTransformedAST)")
      System.print("NullTransform same check: %(Object.same(ast, nullTransformedAST))")
      ast = nullTransformedAST
    }
    if (false) {
      var validator = null
      validator = CallReceiverValidator.new()
      if (false) validator = ComposedVisitor.new(validator, CallReceiverValidator.new())
      ast.accept(validator)
    }
    var file = File.create(arguments[1])
    var visitor = SourcePrinter.new(file)
    if (false) visitor = ComposedVisitor.new(visitor, TransformVisitor.new())
    visitor = ComposedVisitor.new(visitor, CharacterTransform.new())
    visitor = ComposedVisitor.new(visitor, EnumTransform.new())
    visitor = ComposedVisitor.new(visitor, StrictEqualityTransform.new())
    visitor = ComposedVisitor.new(visitor, ThisModuleTransform.new())
    visitor = ComposedVisitor.new(visitor, ConstantFoldingTransform.new())
    ast.accept(visitor)
    file.close()
    if (_reporter.has_errors) {
      System.print("Build has errors")
      return 1
    }
  }
}
