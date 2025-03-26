// DO NOT EDIT: This file is automagically generated

import "veery/compiler/reporter" for Severity
class Scope {
  construct new(reporter) {
    _reporter = reporter
    var moduleScope = {"Bool": true, "Class": true, "Fiber": true, "Fn": true, "List": true, "Map": true, "MapEntry": true, "MapKeySequence": true, "MapSequence": true, "MapValueSequence": true, "Null": true, "Num": true, "Object": true, "Range": true, "Sequence": true, "String": true, "StringByteSequence": true, "StringCodePointSequence": true, "System": true, "WhereSequence": true}
    _scopes = [moduleScope]
    _forwardReferences = []
  }
  declare(name) {
    var scope = _scopes[-1]
    if (scope.containsKey(name.toString)) {
      var token = scope[name.toString]
      if (token is Bool) {
        _reporter.call(Severity.Error, "A variable named '%(name)' is already defined in " + "the core library", [name])
      } else {
        _reporter.call(Severity.Error, "A variable named '%(name)' is already defined in " + "this scope, on line %(scope[name].lineStart).", [scope[name.toString], name])
      }
      return
    }
    scope[name.toString] = name
  }
  resolve(name) {
    var reachedClass = false
    for (i in (_scopes.count - 1) .. 0) {
      if (_scopes[i] == null) {
        reachedClass = true
        break
      }
      if (_scopes[i].containsKey(name.toString)) {
        return _scopes[i][name.toString]
      }
    }
    if (reachedClass) {
      if (name.text[0].isLower) {
        return null
      } else {
        if (_scopes[0].containsKey(name.toString)) {
          return _scopes[0][name.toString]
        } else {
          _forwardReferences.add(name)
          return
        }
      }
    }
    _reporter.call(Severity.Error, "Variable '%(name)' is not defined.", [name])
  }
  begin() {
    _scopes.add({})
  }
  end() {
    _scopes.removeAt(-1)
  }
  beginClass() {
    _scopes.add(null)
  }
  endClass() {
    _scopes.removeAt(-1)
  }
  checkForwardReferences() {
    for (use in _forwardReferences) {
      if (!_scopes[0].containsKey(use.toString)) {
        _reporter.call(Severity.Error, "Variable '%(use)' is not defined.", [use])
      }
    }
  }
}
