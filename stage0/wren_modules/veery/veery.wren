// DO NOT EDIT: This file is automagically generated

import "io" for Stdin
import "os" for Platform
import "veery/argument_parser" for ArgumentParser, Option
import "veery/compiler/analyzer" for Analyzer
import "veery/compiler/compiler" for Compiler
import "veery/compiler/shell" for Shell
class Veery {
  construct new() {
  }
  run(arguments) {
    var VEERY_VERSION_STRING = "0.0.0"
    var show_usage = false
    var show_version = false
    while (arguments.count > 0) {
      if (arguments[0] == "-h" || arguments[0] == "--help") {
        show_usage = true
      } else if (arguments[0] == "-v" || arguments[0] == "--version") {
        show_version = true
      } else if (arguments[0] == "--") {
        arguments = arguments[1 .. -1]
        break
      } else {
        break
      }
      arguments = arguments[1 .. -1]
    }
    if (show_usage) {
      System.print("Show usage")
      return 1
    }
    if (show_version) {
      System.print("Show version")
      return 1
    }
    var sub_commands = {"analyze": Analyzer, "compile": Compiler, "shell": Shell}
    var sub_command = sub_commands[arguments[0]]
    if (sub_command == null) {
      sub_command = Shell
    } else {
      arguments = arguments[1 .. -1]
    }
    return sub_command.new().run(arguments)
  }
}
