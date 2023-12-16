import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 위젯
import './widgets/Home.dart';
import './widgets/General.dart';
import './widgets/Business.dart';
import './widgets/Entertainment.dart';
import './widgets/Sports.dart';
import './widgets/Technology.dart';
import './widgets/Science.dart';
import './widgets/Health.dart';

// Get data from server
Future<List<NewsData>> getNewsData(http.Client client, {String category=""}) async {
  String api_url = dotenv.env['API_URL'] ?? "";                 // Get API_URL from env file and Set api_url
  String cat = dotenv.env[category] ?? "";                      // Get Selected category from env file

  final response = await client.get(Uri.parse(api_url + cat));        // Send http GET requests to server url and processes the response

  if (response.headers['content-type']?.toLowerCase().contains('charset=utf-8') != true) {  // Set encoding charset if it is not set in Content-Type header
    response.headers['content-type'] = 'application/json; charset=utf-8';
  }

  if (response.statusCode == 200) {                                   // Response is successful(200 ok), parse the Json
    final List<dynamic> resultList = json.decode(response.body);
    print(resultList);
    return NewsData.fromJsonList(resultList);
  }
  else {                                                              // Response is fail, throw an exception
    throw Exception("Fail to laod");
  }
}

// Define NewsData class
class NewsData {
  final String author;
  final String description;
  final String publishedAt;
  final String title;

  const NewsData({required this.author, required this.description, required this.publishedAt, required this.title});

  factory NewsData.fromJson(Map<String, dynamic> json) {              // Convert JSON data to NewsData object
    return NewsData(
      author: json['author'] ?? 'Unknown Author',
      description: json['description'] ?? 'No description',
      publishedAt: json['publishedAt'] ?? 'Unknown publishedAt',
      title: json['title'] ?? 'No title',
    );
  }
  static List<NewsData> fromJsonList(List<dynamic> jsonList) {        // Convert JSON data to NewsData object(List)
    return jsonList.map((jsonItem) => NewsData.fromJson(jsonItem)).toList();
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();      // Ensure async operation are execute only after initialized is complete
  await dotenv.load();                            // Load environment variables from .env file
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

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  late TabController _tabController;               // Enable tabs scroll horizontally

  @override
  // Called when widget is created
  void initState() {
    super.initState();
    getNewsData(http.Client());                                  // Send GET requests to server
    _tabController = TabController(length: 8, vsync: this);      // Create TabController, specify number of tabs: 8 tabs
  }

  @override
  // Called when widget is completely terminated
  void dispose() {
  _tabController.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
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
            TabBar(                                 // TabBar: 8 tabs
              controller: _tabController,
              isScrollable: true,
              // design property
              indicatorColor: Color(0xff4C7A7E),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),

              tabs: [
                Tab(text: "전체",),
                Tab(text: "정치",),
                Tab(text: "경제",),
                Tab(text: "연예",),
                Tab(text: "스포츠",),
                Tab(text: "기술",),
                Tab(text: "과학",),
                Tab(text: "건강",),
              ],
            ),
            Expanded(
              child:
              TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Home()),              // Tab1: "전체"
                  Center(child: General()),           // Tab2: "정치"
                  Center(child: Business()),          // Tab3: "경제"
                  Center(child: Entertainment()),     // Tab4: "연예"
                  Center(child: Sports()),            // Tab5: "스포츠"
                  Center(child: Technology()),        // Tab6: "기술"
                  Center(child: Science()),           // Tab7: "과학"
                  Center(child: Health()),            // Tab8: "건강"
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}