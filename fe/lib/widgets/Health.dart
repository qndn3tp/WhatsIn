import 'package:flutter/material.dart';
import 'package:whatsin_fe/widgets/widgets.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Health extends StatelessWidget {
  const Health ({super.key});

  // Open external browser with url
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {     // Attempt to open browser(success:return True / fail: return False)
      throw Exception('Could not launch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text space: "어제의 뉴스"
        BodyText(),

        // Main space: News list
        Expanded(
            child: ListView.builder(
                itemCount: 5,                         // itemCount: 5 hottest news in Health
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
                        future: getNewsData(http.Client(), category: "HEALTH"),
                        builder: (context, snapshot) {                                  // snapshot: Object that includes async operation's result, state

                          if (snapshot.connectionState == ConnectionState.waiting) {    // UI: when data is loading
                            return CircularProgressIndicator();
                          }
                          else if (snapshot.hasError) {                                 // UI: when error occurs
                            return Text('Error: ${snapshot.error}');
                          }
                          else {                                                        // UI: when data is successfully received
                            NewsData newsData = snapshot.data![0];

                            String title = newsData.title.length > 50                 // Cut the string to title's maximum length
                                ? newsData.title.substring(0, 50) + '...'
                                : newsData.title;

                            String description = newsData.description.length > 30      // Cut the string to description's maximum length
                                ? newsData.description.substring(0, 30) + '...'
                                : newsData.description;

                            String url_to_image = newsData.url_to_image;

                            String url_to_article = newsData.url_to_article;

                            // News article
                            return Container(
                              child: GestureDetector(
                                onTap: (){
                                  _launchUrl(url_to_article);                   // Clicked => Attempt to open browser(url_to_article)
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // News image
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top: 0,right: 20, bottom: 0),
                                      child: Image.network(
                                          url_to_image,
                                          height: 60,
                                          width: 90,
                                          fit: BoxFit.fill,
                                        errorBuilder: (context, error, stackTrace) {    // If there is an error to load image(None)
                                          return SizedBox(height: 60, width: 90);
                                        },
                                      ),
                                    ),
                                    // News title, News body
                                    Container(
                                      height: 200,
                                      width: 280,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(title, style: Theme.of(context).textTheme.displayMedium,),
                                          Text(description, style: Theme.of(context).textTheme.displaySmall,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
