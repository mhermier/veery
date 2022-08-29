// DO NOT EDIT: This file is automagically generated

import "veery/event/key" for Key
class Action {
  construct new(text) {
    _text = text
  }
  setKeyChord(keyChord) {
    _keyChord = keyChord
    if (keyChord is String) _keyChord = Key.fromString(keyChord)
    return this
  }
  keyChord{
    return _keyChord
  }
  setOnTriggered(onTriggered) {
    _onTriggered = onTriggered
    return this
  }
  onTriggered{
    return _onTriggered
  }
  text{
    return _text
  }
}
