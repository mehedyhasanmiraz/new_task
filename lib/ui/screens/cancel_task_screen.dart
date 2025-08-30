import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_model.dart';

import '../../data/models/task_list_model.dart';
import '../../data/service/network_client.dart';
import '../utills/snack_bar_message.dart';
import '../utills/urls.dart';
import '../widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {

  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    _getAllCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getCancelledTaskInProgress == false,
      replacement: Center(child: CircularProgressIndicator(),),
      child: ListView.separated(
        itemCount: _cancelledTaskList.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index){
          return TaskCard(taskStatus: TaskStatus.cancelled, taskModel: _cancelledTaskList[index], );
        },
        separatorBuilder: (context, index)=>SizedBox(height: 8),

      ),
    );

  }
  Future<void> _getAllCancelledTaskList() async {
    _getCancelledTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.cancelledTaskUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel =
      TaskListModel.fromJson(response.data ?? {});
      _cancelledTaskList = taskListModel.taskList;
    } else {
      ShowSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }
}
