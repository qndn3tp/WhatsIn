import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(                            // Title
          title: Text("왓츠인"),
          centerTitle: false,
          actions: [
            IconButton(                            // Profile Button
                onPressed: (){},
                icon: Icon(Icons.account_circle)
            )
          ],
        ),
        body: Column(
          children: [
            TabBar(                                 // TabBar: 7 tabs
              // design property
              indicatorColor: Color(0xff4C7A7E),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),

              tabs: [
                Tab(text: "전체",),
                Tab(text: "정치",),
                Tab(text: "사회",),
                Tab(text: "경제",),
                Tab(text: "연예",),
                Tab(text: "스포츠",),
                Tab(text: "세계",),
              ],
            ),
            Expanded(
              child:
              TabBarView(
                children: [
                  Center(child: Text('전체 탭')),      // Tab1: "전체"
                  Center(child: Text('정치 탭')),      // Tab2: "정치"
                  Center(child: Text('사회 탭')),      // Tab3: "사회"
                  Center(child: Text('경제 탭')),      // Tab4: "경제"
                  Center(child: Text('연예 탭')),      // Tab5: "연예"
                  Center(child: Text('스포츠 탭')),     // Tab6: "스포츠"
                  Center(child: Text('세계 탭')),      // Tab7: "세계"
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}