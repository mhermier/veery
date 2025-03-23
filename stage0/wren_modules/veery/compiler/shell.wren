// DO NOT EDIT: This file is automagically generated

import "io" for Stdin
import "os" for Platform
import "veery/argument_parser" for ArgumentParser
import "veery/repl/repl" for AnsiRepl, SimpleRepl
import "veery/veery_version" for VEERY_VERSION_STRING
class Shell {
  construct new() {
  }
  run(arguments) {
    var language
    var argument_parser = ArgumentParser.new{|argument_parser|
      argument_parser.add_option{|option|
        option.long_name = "lang"
        option.help = "Change the language"
        option.arity = 1
        option.callback = Fn.new{|result|
          language = result.arguments_shift()
        }
      }
    }
    var result = argument_parser.parse(arguments)
    arguments = result.arguments
    if (language != "wren") {
      Fiber.abort("Properly implement language support")
    }
    if (arguments.count > 0) {
      Fiber.abort("Properly implement arguments support")
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
