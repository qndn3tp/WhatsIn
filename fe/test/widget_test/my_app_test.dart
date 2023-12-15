import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsin_fe/main.dart';
import 'package:whatsin_fe/widgets/Home.dart';
import 'package:whatsin_fe/widgets/General.dart';
import 'package:whatsin_fe/widgets/Business.dart';
import 'package:whatsin_fe/widgets/Entertainment.dart';
import 'package:whatsin_fe/widgets/Sports.dart';
import 'package:whatsin_fe/widgets/Technology.dart';
import 'package:whatsin_fe/widgets/Science.dart';
import 'package:whatsin_fe/widgets/Health.dart';

void main() {
  // MyApp 위젯 테스트
  testWidgets("MyApp widget test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MyApp()));        // MyApp 위젯을 빌드하고 화면에 표시
    expect(find.text('왓츠인'), findsOneWidget);                  // AppBar에 "왓츠인" 텍스트가 있는지 확인
    expect(find.byIcon(Icons.account_circle), findsOneWidget);  // AppBar에 프로필 아이콘이 있는지 확인

    // TabBar에 해당 탭 텍스트가 있는지 확인
    expect(find.text("전체"), findsOneWidget);
    expect(find.text("정치"), findsOneWidget);
    expect(find.text("경제"), findsOneWidget);
    expect(find.text("연예"), findsOneWidget);
    expect(find.text("스포츠"), findsOneWidget);
    expect(find.text("기술"), findsOneWidget);
    expect(find.text("과학"), findsOneWidget);
    expect(find.text("건강"), findsOneWidget);
  });

  // Home 위젯 테스트
  testWidgets('Test Home widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home(),));        // Home 위젯을 빌드
    expect(find.byType(Home), findsOneWidget);                  // Home 위젯이 화면에 표시되는지 확인
  });

  // General 위젯 테스트
  testWidgets('Test General widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: General(),));    // General 위젯을 빌드
    expect(find.byType(General), findsOneWidget);              // General 위젯이 화면에 표시되는지 확인
  });

  // Business 위젯 테스트
  testWidgets('Test Business widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Business(),));     // Business 위젯을 빌드
    expect(find.byType(Business), findsOneWidget);               // Business 위젯이 화면에 표시되는지 확인
  });

  // Entertainment 위젯 테스트
  testWidgets('Test Entertainment widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Entertainment(),));     // Entertainment 위젯을 빌드
    expect(find.byType(Entertainment), findsOneWidget);               // Entertainment 위젯이 화면에 표시되는지 확인
  });

  // Sports 위젯 테스트
  testWidgets('Test Sports widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Sports(),));     // Sports 위젯을 빌드
    expect(find.byType(Sports), findsOneWidget);               // Sports 위젯이 화면에 표시되는지 확인
  });

  // Technology 위젯 테스트
  testWidgets('Test Technology widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Technology(),));       // Technology 위젯을 빌드
    expect(find.byType(Technology), findsOneWidget);                 // Technology 위젯이 화면에 표시되는지 확인
  });

  // Science 위젯 테스트
  testWidgets('Test Science widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Science(),));      // Science 위젯을 빌드
    expect(find.byType(Science), findsOneWidget);                // Science 위젯이 화면에 표시되는지 확인
  });

  // Health 위젯 테스트
  testWidgets('Test Health widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Health(),));   // Health 위젯을 빌드
    expect(find.byType(Health), findsOneWidget);             // Health 위젯이 화면에 표시되는지 확인
  });
}