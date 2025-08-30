import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_list_model.dart';
import 'package:new_task/data/models/task_model.dart';
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
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  bool _getNewTaskInProgress = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    _getListStatusCount();
    _getAllNewTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh:  _getAllNewTaskList,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Visibility(
                  visible: _getStatusCountInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: buildSummerySection(),
                ),
              ),
              SizedBox(
                height: 600,
                child: Visibility(
                  visible: _getNewTaskInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskStatus: TaskStatus.sNew,
                        taskModel: _newTaskList[index],
                        refreshList: _getAllNewTaskList,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: _newTaskList.length,
                  ),
                ),
              ),
            ],
          ),
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
      ),
    );
  }

  Future<void> _getListStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }
}
