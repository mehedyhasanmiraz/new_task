import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_model.dart';

import '../../data/models/task_list_model.dart';
import '../../data/service/network_client.dart';
import '../utills/snack_bar_message.dart';
import '../utills/urls.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getCompleteTaskInProgress = false;
  List<TaskModel> _completeTaskList = [];

  @override
  void initState() {
    _getAllCompleteTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getCompleteTaskInProgress == false,
      replacement: Center(child: CircularProgressIndicator()),
      child: ListView.separated(
        itemCount: _completeTaskList.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return TaskCard(
            taskStatus: TaskStatus.completed,
            taskModel: _completeTaskList[index],
            refreshList: _getAllCompleteTaskList,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
      ),
    );
  }

  Future<void> _getAllCompleteTaskList() async {
    _getCompleteTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completeTaskUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completeTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompleteTaskInProgress = false;
    setState(() {});
  }
}
