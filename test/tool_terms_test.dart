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
}
