import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_status_count_list_model.dart';
import 'package:new_task/data/service/network_client.dart';
import 'package:new_task/ui/screens/add_new_task_screen.dart';
import 'package:new_task/ui/utills/snack_bar_message.dart';
import 'package:new_task/ui/utills/urls.dart';

import '../../data/models/task_status_count_model.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}




class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _geStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    _getListStatusCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSummerySection(),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TaskCard(taskStatus: TaskStatus.sNew);
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _onTapAddNewTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }

  Widget buildSummerySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100, // fixed height for horizontal list
        child: ListView.builder(
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _taskStatusCountList.length,
          itemBuilder: (context, index) {
            return SummaryCard(
              title: _taskStatusCountList[index].status,
              count: _taskStatusCountList[index].count,
            );
          },
        ),
      )

    );
  }

  Future<void> _getListStatusCount() async {
    _geStatusCountInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      ShowSnackBarMessage(context, response.errorMessage, true);
    }
    _geStatusCountInProgress = false;
    setState(() {});
  }
}
