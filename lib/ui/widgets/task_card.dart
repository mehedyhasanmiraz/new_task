import 'package:flutter/material.dart';
import 'package:new_task/data/models/task_model.dart';


enum TaskStatus{
  sNew,
  progress,
  completed,
 cancelled;
}

class TaskCard extends StatelessWidget {
  final TaskStatus  taskStatus;
  final TaskModel taskModel;

   TaskCard({
    super.key, required this.taskStatus, required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskModel.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              taskModel.description            ),
            SizedBox(height: 20,),

            Text("Date: ${taskModel.createdDate}"),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(taskModel.status,style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                  side: BorderSide.none,
                  backgroundColor: _getStatusChipColor(),),
                Spacer(),

                IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: Colors.blue,)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.red,))
              ],
            )
          ],
        ),
      ),
    );
  }


  Color _getStatusChipColor(){

    late Color color;

    switch(taskStatus){

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

}