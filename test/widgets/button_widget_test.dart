import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:breeds_dogs/widgets/buton.widget.dart';

void main() {
  testWidgets('Test if ButtonWidget is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ButtonWidget(
          title: 'Test Button',
          onPressed: () {},
        ),
      ),
    ));

    final buttonFinder = find.text('Test Button');
    expect(buttonFinder, findsOneWidget);
  });
}
