// DO NOT EDIT: This file is automagically generated

import "veery/compiler/reporter" for Severity
class Warning {
  construct new_(compiler, name, desc, severity) {
    _compiler = compiler
    _name = name
    _desc = desc
    _severity = severity
  }
  compiler{
    return _compiler
  }
  name{
    return _name
  }
  desc{
    return _desc
  }
  severity{
    return _severity
  }
  severity=(severity) {
    if (_severity != Severity.Error) {
      _severity = severity
    }
    return _severity
  }
}
