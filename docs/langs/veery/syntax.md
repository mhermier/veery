
**THIS IS JUST A BUNCH OF SYNTAX TO SHOWS WHAT IS SUPPORTED**
**THE LANGUAGE IS NOT FINALISED YET, SO EXPECT CHANGES**

Mix of wren and C style like syntax:

enum MyEnum {
  foo,
  bar,
  baz,
}

'a'; // Unicode character litteral
"abc"; // UTF8-String of unicode character litteral
[1, 2, 3 ]; // List are supported, trailing ',' is optionnal
{1 = 'a', 2 = 'b', 3 = 'c' }; // Maps are supported, trailing ',' is optionnal

class MyClass {
  construct new() {}

  a {
    return .b; // The unary left "." operator resolves to "this."
  }

  b {
    return ..MyClass; // The unary left ".." operator resolves to "this_module."
  }

  c {
    // Trailing function block are supported like in wren
    // (thought syntax may be revised later to look more like lambda ?)
    return Fn.new {|a, b, c| return a + b * c; }
  }

  // One liner block still works, but syntax will probably change later
  // So it is not encouraged
  d { 42 }

  e {
    a; b; c; d // Trailing ';' is optional
  }
}

"this_module" is a keyword meant to resolve access to the top level of the
current module context. (Support is limited when transpiling to wren langage)
