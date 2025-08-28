import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final String title;
  final int count;

  const SummaryCard({
    super.key, required this.title, required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
            children: [
          Text("$count",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          Text(title,style: TextStyle(fontSize: 18),),
        ]),
      ),
    );
  }
}