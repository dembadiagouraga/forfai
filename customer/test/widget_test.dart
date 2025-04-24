import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quick/presentation/app_widget.dart'; // Updated import path

void main() {
  testWidgets('Basic app test', (WidgetTester tester) async {
    await tester.pumpWidget(const AppWidget());
    
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
