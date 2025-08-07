import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index){
        return TaskCard(taskStatus: TaskStatus.cancelled,);
      },
      separatorBuilder: (context, index)=>SizedBox(height: 8),
      itemCount: 10,
    );

  }
}
