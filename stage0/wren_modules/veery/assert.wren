// DO NOT EDIT: This file is automagically generated

class Assert {
  static call(expect) {
    if (expect) return expect
    Fiber.abort("Assertion failed")
  }
  static call(expect, message) {
    if (expect) return expect
    Fiber.abort("Assertion failed: %(message)")
  }
}
