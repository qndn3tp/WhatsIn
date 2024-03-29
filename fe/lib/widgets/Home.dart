import 'package:flutter/material.dart';
import 'package:whatsin_fe/widgets/widgets.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../style.dart' as style;

class Home extends StatelessWidget {
  Home({super.key});

  Future<void> _launchUrl(String url) async{
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch');
    }
  }

  // Categories
  final categories = ['GENERAL', 'BUSINESS', 'ENTERTAINMENT', 'SPORTS', 'TECHNOLOGY', 'SCIENCE', 'HEALTH'];
  final categories_ko = ['정치', '경제', '연예', '스포츠', '기술', '과학', '건강'];

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
              itemCount: categories.length,                         // itemCount: 7 categories in categories list
              itemBuilder: (c, i){                                  // loop categories list, then receive all category's NewsData
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
                      future: getNewsData(http.Client(), category: categories[i]),
                      builder: (context, snapshot) {                                  // snapshot: Object that includes async operation's result, state

                        if (snapshot.connectionState == ConnectionState.waiting) {    // UI: when data is loading
                          return CircularProgressIndicator();
                        }
                        else if (snapshot.hasError) {                                 // UI: when error occurs
                          return Text('Error: ${snapshot.error}');
                        }
                        else {                                                        // UI: when data is successfully received
                          NewsData newsData = snapshot.data![0];

                          String title = newsData.title.length > 50                   // Cut the string to title's maximum length
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
                                    height: 200,
                                    width: 90,
                                    child: Column(
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     SizedBox(width: 30,),
                                        //     Text(categories_ko[i], style: style.catTextStyle,),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 5,),
                                        Text(categories_ko[i], style: style.catTextStyle,),
                                        SizedBox(height: 3,),
                                        Image.network(
                                          url_to_image,
                                          width: 200,
                                          height: 60,
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, error, stackTrace) {    // If there is an error to load image(None)
                                            return SizedBox(height: 60, width: 90);
                                          },
                                        )
                                      ],
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
          ),
        )
      ],
    );
  }
}