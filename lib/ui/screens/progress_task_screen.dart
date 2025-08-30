import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_model.dart';

import '../../data/models/task_list_model.dart';
import '../../data/service/network_client.dart';
import '../utills/snack_bar_message.dart';
import '../utills/urls.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool _getProgressTaskInProgress = true;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getProgressTaskInProgress == false,
      replacement: Center(child: CircularProgressIndicator(),),
      child: ListView.separated(
        itemCount: _progressTaskList.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index){
          return TaskCard(
                taskStatus: TaskStatus.progress,
                taskModel: _progressTaskList[index],);
      },
      separatorBuilder: (context, index)=>SizedBox(height: 8),

      )
    );
  }

  Future<void> _getAllProgressTaskList() async {
    _getProgressTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.ProgressTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel =
      TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
    } else {
      ShowSnackBarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskInProgress = false;
    setState(() {});
  }
}
