# tool_terms

The term language from
[agent_loop's tools-as-data design](https://github.com/intersyntactic/agent_loop/pull/35),
built by hand, one stage at a time. Each stage ends with its tests passing.

1. Values and three terms: `Literal`, `Lower`, `EndsWith`; `evaluate`.
2. `if`: a form, which evaluates only the branch it picks.
3. The parser: JSON lists into the tree, rejecting bad shapes.
4. `input`, `let` and `var`: names that can't shadow each other.
5. The checker: `["lower", true]` is refused before anything runs.
6. `propose` and `next(input, outcomes)`: a program that can only ask.

```
dart test
dart analyze --fatal-infos
```
