// DO NOT EDIT: This file is automagically generated

import "veery/event/key" for Key
class Actions {
  static new() {
    return new([])
  }
  construct new(actions) {
    _list = actions
  }
  add(action) {
    _list.add(action)
  }
  onKeyPressed(key) {
    for (action in _list) {
      if ((action.keyChord is Key && action.keyChord.toKeyCode == key) || action.keyChord == key) {
        action.onTriggered.call()
        return true
      }
    }
    return false
  }
}
