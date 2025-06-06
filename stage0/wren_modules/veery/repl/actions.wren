// DO NOT EDIT: This file is automagically generated

import "veery/event/key" for Key
import "veery/repl/action" for Action
class Actions {
  static new() {
    return new{
    }
  }
  construct new(setup_fn) {
    _actions = []
    setup_fn.call(this)
  }
  add_action(setupFn) {
    var action = Action.new_(this, setupFn)
    _actions.add(action)
    return this
  }
  onKeyPressed(key) {
    for (action in _actions) {
      for (key_chord in action.key_chords) {
        if ((key_chord is Key && key_chord.toKeyCode == key) || key_chord == key) {
          action.trigger()
          return true
        }
      }
    }
    return false
  }
}
