import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aplazo_app/utils/utils.dart';

void main() {
  testWidgets('showErrorDialog shows a dialog with the correct title and message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Utils.showErrorDialog(context, 'Test Title', 'Test Message');
                  },
                  child: Text('Show Dialog'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pump();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Message'), findsOneWidget);
  });
}
