import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index){
        return TaskCard(text: 'Complete', color: Colors.green,);
      },
      separatorBuilder: (context, index)=>SizedBox(height: 8),
      itemCount: 10,
    );
  }
}
