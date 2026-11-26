import 'package:test/test.dart';
import 'package:tool_terms/tool_terms.dart';

void main() {
  group('stage 1: evaluate', () {
    test('a .DOCX name ends with .docx once lowered', () {
      final term = EndsWith(
        Lower(Literal(Text('REPORT.DOCX'))),
        Literal(Text('.docx')),
      );

      expect(
        evaluate(term),
        isA<Flag>().having((f) => f.value, 'value', true),
      );
    });

    // Your test: one you expect to give false.
  });

  group('stage 1: parse', () {
    test('reads the same term from JSON', () {
      final term = parse(['endsWith', ['lower', 'REPORT.DOCX'], '.docx']);

      expect(term, isNotNull);
      expect(
        evaluate(term!),
        isA<Flag>().having((f) => f.value, 'value', true),
      );
    });

    test('a bare string is text, and true is a flag', () {
      expect(
        parse('hi').map(evaluate),
        isA<Text>().having((t) => t.text, 'text', 'hi'),
      );
      expect(
        parse(true).map(evaluate),
        isA<Flag>().having((f) => f.value, 'value', true),
      );
    });

    test('a shape it does not know is null, never a guess', () {
      expect(parse(['lower']), isNull); // missing its operand
      expect(parse(['lower', 'a', 'b']), isNull); // one too many
      expect(parse(['shout', 'a']), isNull); // no such operation
      expect(parse(42), isNull); // no numbers yet
    });
  });
}

extension on Term? {
  /// Applies [f] when this parsed; null when it didn't.
  Value? map(Value Function(Term) f) => switch (this) {
    final term? => f(term),
    null => null,
  };
}
