# Compiler Project 1

## Features

- **Token Categories**:
  - Identifiers: Identifies valid identifiers in Cactus.
  - 18 Keywords: And, Begin, Do, Else, End, EndIf, EndWhile, Exit, If, Set, Not, Or, Program, Read, Then, Var, While, Write.
  - Integer constants: Parses sequences of digits.
  - Operators: Supports 14 operators such as `+`, `-`, `*`, `/`, `%`, `=`, `==`, `<>`, `>`, `>=`, `<`, `<=`, `(`, `)`.
  - Whitespace: Whitespace (blanks, tabs, newlines, carriage returns) is ignored.
  - Comments: Single-line comments starting with `//` are ignored.
- **-s Option**
  - When executed with the `-s` option, the lexical analyzer prints recognized tokens to `stdout` in the following format:
    - `Identifier: <identifier>`
    - `Keyword: <keyword>`
    - `Integer Constant: <integer>`
    - `Operator: <operator>`
- **Error Handling**
  - If an unknown character is encountered, the lexical analyzer will print a
    `Lexical error` message with the line number to `stderr`
    `Lexical error: line %d: unknown character %c\n `

## Generate the scanner

- Compile the Flex source file (cactus.l) into a C source file (lex.yy.c):

```bash
flex cactus.l
```

- Compile the C source file into an executable (scanner):

```bash
gcc -o scanner lex.yy.c
```

## Usage

### Basic Usage

- To run the lexical analyzer without the `-s` option (this will not print tokens):

```bash
./scanner < input
```

### With `-s` Option

- To run the lexical analyzer with the `-s` option (this will print tokens to `stdout`):

```bash
./scanner -s < input
```
