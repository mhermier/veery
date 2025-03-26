// DO NOT EDIT: This file is automagically generated

import "veery/character" for Character
import "veery/event/key" for Key
class Action {
  construct new_(actions, setup_fn) {
    _actions = actions
    _key_chords = []
    setup_fn.call(this)
  }
  description{
    return _description
  }
  description=(description) {
    return _description = description
  }
  key_chords{
    return _key_chords
  }
  add_key_chord(key_chord) {
    if (key_chord is Character) key_chord = Key.fromCharacter(key_chord)
    if (key_chord is String) key_chord = Key.fromString(key_chord)
    _key_chords.add(key_chord)
  }
  on_triggered{
    return _on_triggered_fn
  }
  on_triggered(on_triggered_fn) {
    return _on_triggered_fn = on_triggered_fn
  }
  trigger() {
    return _on_triggered_fn.call()
  }
}
