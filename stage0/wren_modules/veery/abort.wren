// DO NOT EDIT: This file is automagically generated

class Abort {
  static call(msg) {
    Fiber.abort(msg)
  }
  static error(msg) {
    call("Error: %(msg)")
  }
  static internal_error(msg) {
    call("Internal error: %(msg)")
  }
  static runtime_error(msg) {
    call("Runtime error: %(msg)")
  }
  static subclass_responsibility() {
    call("subclass responsibility")
  }
  static subclass_responsibility(class_instance) {
    this.call("subclass responsibility of %(class_instance.name) class")
  }
  static todo() {
    call("TODO")
  }
  static todo(msg) {
    call("TODO: %(msg)")
  }
}
