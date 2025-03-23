// DO NOT EDIT: This file is automagically generated

import "veery/compiler/reporter" for Severity
import "veery/compiler/warning" for Warning
class CompilationContext {
  construct new(compiler, reporter) {
    _compiler = compiler
    _reporter = reporter
    _error_count = 0
  }
  compiler{
    return _compiler
  }
  reporter{
    return _reporter
  }
  has_errors{
    return _error_count > 0
  }
  error_count{
    return _error_count
  }
  call(severity, message, tokens) {
    return this.report(severity, message, tokens)
  }
  report(severity_or_warning, message, tokens) {
    var warning = severity_or_warning is Warning? severity_or_warning : _compiler.warning(severity_or_warning)
    var severity = warning.severity
    if (severity == Severity.None) {
      return
    }
    if (severity == Severity.Error) {
      _error_count = _error_count + 1
    }
    _reporter.call(warning, message, tokens)
  }
}
