import 'package:flutter/material.dart';
import 'package:new_task/ui/widgets/tm_appbar.dart';

import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSummerySection(),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index){
                return TaskCard(text: 'New', color: Colors.blue,);
              },
              separatorBuilder: (context, index)=>SizedBox(height: 8),
              itemCount: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget buildSummerySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SummaryCard(title: 'New', count: 12),
            SummaryCard(title: 'Completed', count: 15),
            SummaryCard(title: 'Cancelled', count: 10),
            SummaryCard(title: 'Progress', count: 20),
          ],
        ),
      ),
    );
  }
}
