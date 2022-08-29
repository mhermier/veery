
**VEERY IS STILL IN VEERY EALY STAGES OF DEVELLOPEMENT AND SUBJECT TO CHANGE**

## The veery analyzer/compiler/interpreter suite

 * **Support the veery language**: The suite provide the main environment for
   compiling, running and interpreting the **veery** language.

 * **The suite is self hosted**: The suite is written in the **veery** language.

 * **The suite is versatile**:
   The compiler infrastructure is written in a simple language without a long history.
   It is simple to modify the supported languages and write tools for and with it.

## Supported languages 

 * **veery**:
   The primary language of the project.

 * **[wren](http://wren.io/)**:
   The language is supported as a secondary language for the suite.
   It is also the primary target for the transpilation process because of the
   origins of the project.

## Limitations:

 * **A specific version of wren-cli is required**
   https://github.com/wren-lang/wren-cli/pull/146 add `Stdin.readBytes()`.
   That change is required for the console, allowing any bytes (and unicode
   characters) to be properly read from `Stdin`.

 * **Compiler is early stages of devellopement**:
   The project is new and the infrastructure is still fragile.
   Expect bugs, syntax changes and no reliability till things get more
   battle-tested and test put in place.

 * **Transpiling to wren**
   There may be some non intuitive limitations due to the process of transpiling
   in the resulting wren ouputs. So tests the outputs and expect to add some odd
   quirks in the veery source, so that your code transpile successfully.

## Inspirations

 * **[wren](http://wren.io/)**:
   The project takes its roots in the tooling and environnement provided by this
   project.
