import 'package:flutter/material.dart';

class TechScience extends StatelessWidget {
  const TechScience({super.key});

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
                itemCount: 5,                         // itemCount: 5 hottest news in Tech and Science
                itemBuilder: (c, i){
                  return Container(
                    // Design property
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // News image
                        Container(
                          height: 50,
                          width: 60,
                          child:Icon(Icons.image),
                        ),
                        //News title, News body
                        Container(
                          width: 200,
                          child: Column(
                            children: [
                              Text("기사 제목", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                              Text("기사 본문", style: TextStyle(fontSize: 15),),
                            ],
                          ),
                        )
                      ],
                    ),
                  );}
            )
        )
      ],
    );
  }
}