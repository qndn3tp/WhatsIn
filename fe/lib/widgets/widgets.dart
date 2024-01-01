import 'package:flutter/material.dart';

// Text space: "어제의 뉴스"
class BodyText extends StatelessWidget {
  const BodyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, top:50, right: 0, bottom: 20),
      child: Text("어제의 뉴스", style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
