// DO NOT EDIT: This file is automagically generated

import "veery/character" for Character
import "os" for Process
class ArgumentParserResult {
  construct new(argument_parser, arguments) {
    _argument_parser = argument_parser
    _arguments = arguments
  }
  argument_parser{
    return _argument_parser
  }
  program_name{
    return _program_name
  }
  program_name=(program_name) {
    return _program_name = program_name
  }
  arguments{
    return _arguments
  }
  arguments_shift() {
    return _arguments.removeAt(0)
  }
}
class Option {
  construct new() {
    new{
    }
  }
  construct new(setupFn) {
    _arity = 0
    setupFn.call(this)
  }
  short_name{
    return _short_name
  }
  short_name=(short_name) {
    return _short_name = short_name
  }
  long_name{
    return _long_name
  }
  long_name=(long_name) {
    return _long_name = long_name
  }
  arity{
    return _arity
  }
  arity=(arity) {
    return _arity = arity
  }
  help{
    return _help
  }
  help=(help) {
    return _help = help
  }
  callback{
    return _callback
  }
  callback=(callback) {
    return _callback = callback
  }
}
class ArgumentParser {
  construct new() {
    new{
    }
  }
  construct new(setupFn) {
    _options = {}
    setupFn.call(this)
    add_option{|option|
      option.short_name = Character.fromCodePoint(104)
      option.long_name = "help"
      option.help = "show this help message and exit"
      option.callback = Fn.new{
        this.show_help()
      }
    }
    if (_program_version != null) {
      add_option{|option|
        option.short_name = Character.fromCodePoint(118)
        option.long_name = "version"
        option.help = "show version informations and exit"
        option.callback = Fn.new{
          this.show_version()
        }
      }
    }
  }
  program_name{
    return _program_name
  }
  program_name=(program_name) {
    return _program_name = program_name
  }
  program_version{
    return _program_version
  }
  program_version=(program_version) {
    return _program_version = program_version
  }
  add_option(setupFn) {
    var option = Option.new(setupFn)
    register_option_short_name_(option, option.short_name)
    register_option_long_name_(option, option.long_name)
    return this
  }
  register_option_short_name_(option, short_name) {
    if (short_name == null) return
    _options["-%(short_name)"] = option
  }
  register_option_long_name_(option, long_name) {
    if (long_name == null) return
    _options["--%(long_name)"] = option
  }
  parse() {
    return parse(Process.arguments)
  }
  parse(arguments) {
    var result = ArgumentParserResult.new(this, arguments)
    while (result.arguments.count > 0) {
      var current = result.arguments[0]
      if (current == "--") {
        break
      }
      var option
      if (option = _options[current]) {
        result.arguments_shift()
        option.callback.call(result)
      } else if (current.startsWith("--")) {
        var assign_index = current.indexOf("=")
        if (assign_index < 0) {
          Fiber.abort("Handle unknown long option")
        }
        var lhs = current[0 ... assign_index]
        var rhs = current[assign_index + 1 .. -1]
        option = _options[lhs]
        if (!option) {
          Fiber.abort("Handle unknown long option")
        }
        if (option.arity != 1) {
          Fiber.abort("Handle assign long option must have an arity of 1 argument")
        }
        result.arguments[0] = lhs
        result.arguments.insert(1, rhs)
        continue
      } else if (current.startsWith("-") && current.count >= 2) {
        var lhs = current[0 .. 1]
        var rhs = current[2 .. -1]
        option = _options[lhs]
        if (!option) {
          Fiber.abort("Handle unknown short option")
        }
        if (option.arity == 0) {
          result.arguments[0] = lhs
          result.arguments.insert(1, "-%(rhs)")
        } else if (option.arity == 1) {
          result.arguments[0] = lhs
          result.arguments.insert(1, rhs)
        } else {
          Fiber.abort("Handle assign short option must have an arity of 2+ argument")
        }
        continue
      } else {
        break
      }
    }
    return result
  }
  show_help() {
    this.show_usage()
    Fiber.abort("Exit more gracefully")
  }
  show_usage() {
    System.print("Usage: %(program_name) [OPTIONS]...")
    Fiber.abort("Exit more gracefully")
  }
  show_version() {
    System.print(_program_version)
    Fiber.abort("Exit more gracefully")
  }
}
