/// Reads a term as one line of JSON, works it out, and prints its value.
///
///     dart run bin/repl.dart
///     terms> ["endsWith", ["lower", "REPORT.DOCX"], ".docx"]
///     true
///
/// `:q` (or end of input) quits. Restart it to pick up changes to lib/.
library;

import 'dart:convert' show jsonDecode;
import 'dart:io';

import 'package:tool_terms/tool_terms.dart';

void main() {
  while (true) {
    stdout.write('terms> ');
    final line = stdin.readLineSync()?.trim();
    // wire-ok: the one command typed at the prompt, read once here
    if (line == null || line == ':q') return;
    if (line.isEmpty) continue;
    stdout.writeln(_run(line));
  }
}

/// [line] read, parsed, worked out and shown, or why it couldn't be.
String _run(String line) {
  final Object? json;
  try {
    json = jsonDecode(line);
  } on FormatException catch (e) {
    return 'not JSON: ${e.message}';
  }
  final term = parse(json);
  if (term == null) return 'not a term: $line';
  try {
    return _show(evaluate(term));
  } on Object catch (e) {
    // The REPL is where a bad term gets tried, so it reports and carries
    // on rather than ending the session; the checker (stage 5) will stop
    // such terms before they run.
    return 'failed while evaluating: $e';
  }
}

/// [value] as JSON writes it.
String _show(Value value) => switch (value) {
  Text(:final text) => '"$text"',
  Flag(:final value) => '$value',
};
