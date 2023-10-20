import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsin_fe/main.dart';

void main() {
  testWidgets("MyApp widget test", (WidgetTester tester) async {
    // MyApp 위젯을 빌드하고 화면에 표시
    await tester.pumpWidget(MaterialApp(home: MyApp()));

    // AppBar에 "왓츠인" 텍스트가 있는지 확인
    expect(find.text('왓츠인'), findsOneWidget);

    // AppBar에 프로필 아이콘이 있는지 확인
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
  });
}