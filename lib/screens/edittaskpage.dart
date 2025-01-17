import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTaskPage extends StatefulWidget {
  final String taskId;
  final String initialTask;

  const EditTaskPage({
    required this.taskId,
    required this.initialTask,
    Key? key,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _taskController;

  @override
  void initState() {
    // TODO: implement initState
    _taskController = TextEditingController(text: widget.initialTask);
  }

  Future<void> updateTask() async {
    if(_formkey.currentState!.validate()){
      try{
        await FirebaseFirestore.instance.collection('tasks').doc(widget.taskId)
            .update({

        });
      }
      catch(e){
        Get.showSnackbar(
            GetSnackBar(
              message: 'Failed to update task : $e',
            ));
      }
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Center(
        child: Text('Edit your task here!'),
      ),
    );
  }
}
