import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class Science extends StatelessWidget {
  const Science ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text space: "어제의 뉴스"
        Container(
          margin: EdgeInsets.only(left: 35, top:50, right: 0, bottom: 20),
          child: Text("어제의 뉴스", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),

        // Main space: News list
        Expanded(
            child: ListView.builder(
                itemCount: 5,                         // itemCount: 5 hottest news in Science
                itemBuilder: (c, i){
                  return Container(
                    // Design property
                      height: 130,
                      width: 500,
                      margin: EdgeInsets.only(left: 35, top: 20, right: 35, bottom: 0),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xffFAFAFA),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffE6E6E6),
                              offset: Offset(0, 5),
                              blurRadius: 8.0,
                            )
                          ]
                      ),

                      // Content
                      child: FutureBuilder<List<NewsData>>(                             // Perform async operation
                        future: getNewsData(http.Client(), category: "SCIENCE"),
                        builder: (context, snapshot) {                                  // snapshot: Object that includes async operation's result, state

                          if (snapshot.connectionState == ConnectionState.waiting) {    // UI: when data is loading
                            return CircularProgressIndicator();
                          }
                          else if (snapshot.hasError) {                                 // UI: when error occurs
                            return Text('Error: ${snapshot.error}');
                          }
                          else {                                                        // UI: when data is successfully received
                            NewsData newsData = snapshot.data![0];

                            String title = newsData.title.length > 20                   // Cut the string to title's maximum length
                                ? newsData.title.substring(0, 30) + '...'
                                : newsData.title;

                            String description = newsData.description.length > 100      // Cut the string to description's maximum length
                                ? newsData.description.substring(0, 80) + '...'
                                : newsData.description;

                            //News title, News body
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                Text(description, style: TextStyle(fontSize: 13),),
                              ],
                            );
                          }
                        },
                      )
                  );}
            )
        )
      ],
    );
  }
}
