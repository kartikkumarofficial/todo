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
          'task':_taskController.text
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Edit Task',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.task),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: updateTask,
                  child: Text('Saved Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
