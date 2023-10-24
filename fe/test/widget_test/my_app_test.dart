import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsin_fe/main.dart';
import 'package:whatsin_fe/widgets/Home.dart';
import 'package:whatsin_fe/widgets/Politics.dart';
import 'package:whatsin_fe/widgets/Economy.dart';
import 'package:whatsin_fe/widgets/Society.dart';
import 'package:whatsin_fe/widgets/Culture.dart';
import 'package:whatsin_fe/widgets/World.dart';
import 'package:whatsin_fe/widgets/Sports.dart';
import 'package:whatsin_fe/widgets/TechScience.dart';

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
    expect(find.text("사회"), findsOneWidget);
    expect(find.text("문화"), findsOneWidget);
    expect(find.text("세계"), findsOneWidget);
    expect(find.text("스포츠"), findsOneWidget);
    expect(find.text("IT/과학"), findsOneWidget);
  });

  // Home 위젯 테스트
  testWidgets('Test Home widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home(),));        // Home 위젯을 빌드
    expect(find.byType(Home), findsOneWidget);                  // Home 위젯이 화면에 표시되는지 확인
  });

  // Politics 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Politics(),));    // Politics 위젯을 빌드
    expect(find.byType(Politics), findsOneWidget);              // Politics 위젯이 화면에 표시되는지 확인
  });

  // Economy 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Economy(),));     // Economy 위젯을 빌드
    expect(find.byType(Economy), findsOneWidget);               // Economy 위젯이 화면에 표시되는지 확인
  });

  // Society 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Society(),));     // Society 위젯을 빌드
    expect(find.byType(Society), findsOneWidget);               // Society 위젯이 화면에 표시되는지 확인
  });

  // Culture 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Culture(),));     // Culture 위젯을 빌드
    expect(find.byType(Culture), findsOneWidget);               // Culture 위젯이 화면에 표시되는지 확인
  });

  // World 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: World(),));       // World 위젯을 빌드
    expect(find.byType(World), findsOneWidget);                 // World 위젯이 화면에 표시되는지 확인
  });

  // Sports 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Sports(),));      // Sports 위젯을 빌드
    expect(find.byType(Sports), findsOneWidget);                // Sports 위젯이 화면에 표시되는지 확인
  });

  // TechScience 위젯 테스트
  testWidgets('Test Politics widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TechScience(),));   // TechScience 위젯을 빌드
    expect(find.byType(TechScience), findsOneWidget);             // TechScience 위젯이 화면에 표시되는지 확인
  });
}