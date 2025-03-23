// DO NOT EDIT: This file is automagically generated

import "io" for Directory, File
import "veery/abort" for Abort
import "veery/argument_parser" for ArgumentParser
import "veery/character" for Character
import "veery/character_string" for CharacterString
import "veery/compiler/abstract_lang/identity_visitor" for IdentityVisitor
import "veery/compiler/abstract_lang/source_file" for SourceFile
import "veery/compiler/abstract_lang/transform_visitor" for TransformVisitor
import "veery/compiler/compilation_context" for CompilationContext
import "veery/compiler/reporter" for JsonReporter, PrettyReporter, Severity
import "veery/compiler/warning" for Warning
import "veery/veery_version" for VEERY_VERSION_STRING
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
    _warnings = {}
    _generic_notice = register_warning("notice", "Generic notice report context", Severity.Notice)
    _generic_warning = register_warning("warning", "Generic warning report context", Severity.Warning)
    _generic_error = register_warning("error", "Generic error report context", Severity.Error)
    _warnings[Severity.Warning] = _generic_warning
    _warnings[Severity.Error] = _generic_error
  }
  generic_notice{
    return _generic_notice
  }
  generic_warning{
    return _generic_warning
  }
  generic_error{
    return _generic_error
  }
  warnings{
    return _warnings
  }
  warning(name) {
    return _warnings[name]
  }
  register_warning(name, desc, severity) {
    if (warning(name) != null) {
      Abort.internal_error("Already registered reporter context named: %(name)")
    }
    return _warnings[name] = Warning.new_(this, name, desc, severity)
  }
  parseFile(compilation_context, path) {
    var code = CharacterString.fromString(File.read(path))
    var source = SourceFile.new(path, code)
    var ast = _parser.parse(compilation_context, source)
    return ast
  }
  run(arguments) {
    var language
    var output_file_path
    var reporter_class = PrettyReporter
    var warning_modifiers = []
    var argument_parser = ArgumentParser.new{|argument_parser|
      argument_parser.program_name = "veery compile"
      argument_parser.program_version = VEERY_VERSION_STRING
      argument_parser.add_option{|option|
        option.long_name = "json"
        option.help = "Output result in json format"
        option.callback = Fn.new{
          reporter_class = JsonReporter
        }
      }
      argument_parser.add_option{|option|
        option.long_name = "lang"
        option.help = "Change the language"
        option.arity = 1
        option.callback = Fn.new{|result|
          language = result.arguments_shift()
        }
      }
      argument_parser.add_option{|option|
        option.short_name = Character.fromCodePoint(111)
        option.long_name = "output"
        option.help = "Set the destination output file name"
        option.callback = Fn.new{|result|
          output_file_path = result.arguments_shift()
        }
      }
      argument_parser.add_option{|option|
        option.short_name = Character.fromCodePoint(119)
        option.help = "Inhibit all warning messages"
        option.callback = Fn.new{|result|
          warning_modifiers.add("no-warning")
        }
      }
      argument_parser.add_option{|option|
        option.short_name = Character.fromCodePoint(87)
        option.help = "Enable warning messages"
        option.arity = 1
        option.callback = Fn.new{|result|
          warning_modifiers.add(result.arguments_shift())
        }
      }
    }
    var result = argument_parser.parse(arguments)
    arguments = result.arguments
    if (language != null) {
      System.print("Support other languages than veery")
      return 1
    }
    if (arguments.count == 1) {
      if (output_file_path == null) {
        output_file_path = "a.out"
      }
    } else if (arguments.count == 2 && output_file_path == null) {
      System.print("Warning: output file path moved to the -o option")
      System.print("         compatibility support will be remove in the next release")
      output_file_path = arguments[1]
    } else {
      argument_parser.show_usage()
      return 1
    }
    var pipeline = IdentityVisitor.new()
    _parser = Parser.new(this)
    pipeline = pipeline | CharacterTransform.new()
    pipeline = pipeline | EnumTransform.new()
    pipeline = pipeline | StrictEqualityTransform.new()
    pipeline = pipeline | ThisModuleTransform.new()
    pipeline = pipeline | ConstantFoldingTransform.new()
    if (false) pipeline = pipeline | CallReceiverValidator.new()
    var has_warning_modifiers_errors = false
    for (warning_modifier in warning_modifiers) {
      var enable = true
      var warning = warning_modifier
      if (warning_modifier.startsWith("no-")) {
        enable = false
        warning = warning_modifier[3 .. -1]
      }
      if (warning == "error") {
        if (enable) {
          for (report_context in this.warnings.values) {
            if (report_context.severity == Severity.Warning) {
              report_context.severity = Severity.Error
            }
          }
        } else {
          has_warning_modifiers_errors = true
          System.print("Unable to lower errors")
        }
      } else if (warning == "warning") {
        for (report_context in this.warnings.values) {
          report_context.severity = enable? Severity.Warning : Severity.None
        }
      } else {
        var report_context = this.warning(warning)
        if (report_context == null) {
          has_warning_modifiers_errors = true
          System.print("Unkonwn warning: %(warning)")
        } else {
          report_context.severity = enable? Severity.Warning : Severity.None
        }
      }
    }
    if (has_warning_modifiers_errors) {
      System.print("Unknown warning modifiers")
      return 1
    }
    var compilation_context = CompilationContext.new(this, reporter_class.new())
    var path = arguments[0]
    var ast = parseFile(compilation_context, path)
    var file = File.create(output_file_path)
    pipeline = pipeline | SourcePrinter.new(file)
    ast.accept(pipeline, compilation_context)
    file.close()
    if (compilation_context.has_errors) {
      System.print("Build has errors")
      return 1
    }
  }
}
