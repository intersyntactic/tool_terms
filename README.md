# tool_terms

The term language from
[agent_loop's tools-as-data design](https://github.com/intersyntactic/agent_loop/pull/35),
built by hand, one stage at a time. Each stage ends with its tests passing.

1. Values and three terms: `Literal`, `Lower`, `EndsWith`; `evaluate`, and
   `parse` from JSON, which grows by one case with each new term.
2. `if`: a form, which evaluates only the branch it picks.
3. `input`, `let` and `var`: names that can't shadow each other.
4. The checker: `["lower", true]` is refused before anything runs.
5. `propose` and `next(input, outcomes)`: a program that can only ask.

```
dart test
dart analyze --fatal-infos
```

## Trying terms

`bin/repl.dart` reads a term as one line of JSON, works it out and prints
its value. A bare string is text, `true` and `false` are flags, and a list
starts with its operation's name.

```
dart run bin/repl.dart
terms> ["endsWith", ["lower", "REPORT.DOCX"], ".docx"]
true
terms> ["lower"]
not a term: ["lower"]
terms> :q
```

Restart it after changing `lib/`. A term that fails while evaluating is
reported and the session carries on.
