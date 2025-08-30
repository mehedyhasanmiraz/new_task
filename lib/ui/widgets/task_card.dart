import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_model.dart';
import 'package:new_task/data/service/network_client.dart';
import 'package:new_task/ui/utills/snack_bar_message.dart';
import 'package:new_task/ui/utills/urls.dart';

enum TaskStatus { sNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  TaskCard({super.key, required this.taskStatus, required this.taskModel, required this.refreshList});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(widget.taskModel.description),
            SizedBox(height: 20),

            Text("Date: ${widget.taskModel.createdDate}"),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide.none,
                  backgroundColor: _getStatusChipColor(),
                ),
                Spacer(),

               Visibility(
                 visible: inProgress == false,
                 replacement: Center(child: CircularProgressIndicator(),),
                 child: Row(
                   children: [
                    IconButton(
                     onPressed: () {
                       _showUpdateStatusDialogue();
                     },
                     icon: Icon(Icons.edit, color: Colors.blue),
                   ),
                    IconButton(
                     onPressed: () {},
                     icon: Icon(Icons.delete, color: Colors.red),
                   ),
                 ],),
               )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;

    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;

      case TaskStatus.progress:
        color = Colors.purple;

      case TaskStatus.completed:
        color = Colors.green;

      case TaskStatus.cancelled:
        color = Colors.red;
    }
    return color;
  }

  void _showUpdateStatusDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: (){
                  _popDialogue();
                  if(isSelected("New")) return;
                  _changeTaskStatus("New");
                },
                title: Text("New"),
                trailing: isSelected("New") ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: (){
                  _popDialogue();
                  if(isSelected("Complete")) return;
                  _changeTaskStatus("Complete");
                },
                title: Text("Complete"),
                trailing: isSelected("Complete") ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: (){
                  _popDialogue();
                  if(isSelected("Cancelled")) return;
                  _changeTaskStatus("Cancelled");
                },
                title: Text("Cancelled"),
                trailing: isSelected("Cancelled") ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: (){
                  _popDialogue();
                  if(isSelected("Progress")) return;
                  _changeTaskStatus("Progress");
                },
                title: Text("Progress"),
                trailing: isSelected("Progress") ? Icon(Icons.done) : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _popDialogue(){
    Navigator.pop(context);
  }

  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),);
    inProgress = false;
    if(response.isSuccess){
      widget.refreshList();
    }else{
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
