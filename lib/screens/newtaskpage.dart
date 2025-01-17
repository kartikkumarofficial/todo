import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  void savetask(){
    if(formKey.currentState!.validate()){
      String task = taskController.text;
      Get.showSnackbar(
        GetSnackBar(
          // title: 'Task',
          message: 'Task Saved : $task',
        )
      );
      taskController.clear();

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: taskController,
                key:formKey,
                        decoration: InputDecoration(
              labelText: 'Add task',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.task),
                        ),
                        validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Task';
              }
              return null;
                        },
                      ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: ()async{

                  CollectionReference collref = FirebaseFirestore.instance.collection('tasks');
                  try{
                    await collref.add({
                      'task':taskController.text,
                      'timestamp':FieldValue.serverTimestamp(),

                    });
                    Get.showSnackbar(
                        GetSnackBar(
                          message: 'Task Added',
                          duration: Duration(seconds: 2),
                        )
                    );
                  }
                  catch(e){
                    Get.showSnackbar(
                      GetSnackBar(
                        title: 'Error',
                        message: '$e',
                      )
                    );
                  }
                }, 
                child: Text('Add Task'))


          ],
        ),
      ),
    );
  }
}
