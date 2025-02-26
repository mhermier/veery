// DO NOT EDIT: This file is automagically generated

import "io" for Directory, File
import "veery/argument_parser" for ArgumentParser
import "veery/character_string" for CharacterString
import "veery/compiler/abstract_lang/source_file" for SourceFile
import "veery/compiler/abstract_lang/token" for Token, TokenType
import "veery/compiler/reporter" for JsonReporter, PrettyReporter, Reporter
import "wren_lang/lexer" for Lexer
import "wren_lang/parser" for Parser
import "wren_lang/resolver" for Resolver
class Analyzer {
  construct new() {
  }
  parseFile(path) {
    var code = CharacterString.fromString(File.read(path))
    var source = SourceFile.new(path, code)
    var lexer = Lexer.new(source)
    var parser = Parser.new(lexer, _reporter)
    var ast = parser.parseModule()
    var resolver = Resolver.new(_reporter)
    resolver.resolve(ast)
  }
  processDirectory(path) {
    for (entry in Directory.list(path)) {
      entry = "%(path)/%(entry)"
      if (entry.endsWith(".wren") && File.exists(entry)) {
        parseFile(entry)
      }
    }
  }
  run(arguments) {
    var langage
    var reporter_class = PrettyReporter
    var argument_parser = ArgumentParser.new{|argument_parser|
      argument_parser.add_option{|option|
        option.long_name = "json"
        option.help = "output result in json format"
        option.callback = Fn.new{
          reporter_class = JsonReporter
        }
      }
      argument_parser.add_option{|option|
        option.long_name = "lang"
        option.help = "change the langage"
        option.arity = 1
        option.callback = Fn.new{|result|
          langage = result.arguments_shift()
        }
      }
    }
    var result = argument_parser.parse(arguments)
    if (langage != "wren") {
      Fiber.abort("Properly implement arguments and langage support")
    }
    _reporter = Reporter.new(reporter_class.new())
    if (arguments.count != 1) {
      System.print("Usage: wrenalyzer [--json] <source file>")
      return 1
    }
    var path = arguments[0]
    if (Directory.exists(path)) {
      processDirectory(path)
    } else {
      parseFile(path)
    }
    if (_reporter.has_errors) {
      System.print("Build has errors")
      return 1
    }
  }
}
