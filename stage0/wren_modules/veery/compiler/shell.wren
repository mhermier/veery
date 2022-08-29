// DO NOT EDIT: This file is automagically generated

import "io" for Stdin
import "os" for Platform
import "veery/argument_parser" for ArgumentParser, Option
import "veery/repl/repl" for AnsiRepl, SimpleRepl
class Shell {
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
    if (arguments.count < 1 || arguments[0] != "--lang=wren") {
      System.print(arguments.join(", "))
      Fiber.abort("Properly implement arguments and language support")
    }
    System.print("\\\\/\"-")
    System.print(" \\_/   veery v%(VEERY_VERSION_STRING)")
    if (Platform.isPosix && Stdin.isTerminal) {
      AnsiRepl.new().run()
    } else {
      SimpleRepl.new().run()
    }
  }
}
