// DO NOT EDIT: This file is automagically generated

import "io" for Stdin
import "os" for Platform
import "veery/argument_parser" for ArgumentParser
import "veery/veery_version" for VEERY_VERSION_STRING
import "veery/compiler/analyzer" for Analyzer
import "veery/compiler/compiler" for Compiler
import "veery/compiler/shell" for Shell
class Veery {
  construct new() {
  }
  run(arguments) {
    var argument_parser = ArgumentParser.new{|argument_parser|
      argument_parser.program_name = "veery"
      argument_parser.program_version = VEERY_VERSION_STRING
    }
    var result = argument_parser.parse(arguments)
    arguments = result.arguments
    var sub_commands = {"analyze": Analyzer, "compile": Compiler, "shell": Shell}
    var sub_command = Shell
    if (arguments.count > 0) {
      var maybe_subcommand
      if (maybe_subcommand = sub_commands[arguments[0]]) {
        sub_command = maybe_subcommand
        arguments = arguments[1 .. -1]
      }
    }
    return sub_command.new().run(arguments)
  }
}
