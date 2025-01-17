import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/newtaskpage.dart';
import 'package:todo/widgets/bottomsheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Stream<List<Map<String, dynamic>>> Tasks() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'name': data['task'] ?? 'Reminder',
      };
    }).toList());
  }

  Future<void> deleteTask (String tasksId) async{
    try{
      await FirebaseFirestore.instance.collection('tasks').doc(tasksId).delete();
      Get.showSnackbar(
        GetSnackBar(
          // title: 'Task',
          message: 'Task Deleted',
          duration: Duration(seconds: 2),
        )
      );

    }
    catch(e){
      Get.showSnackbar(
          GetSnackBar(
            title: 'Task',
            message: 'Failed to delete task : $e',
          )
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(71, 240, 255, 1.0),
        title: Text('To Do List'),
      ),
      body:
      Container(
        color: Color.fromRGBO(71, 240, 255, 1.0),
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: Tasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // return Center(child: Text('No tasks available. Add a task!'));
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  // tileColor: Color.fromRGBO(71, 240, 255, 1.0),
                  title: Text('Add a task'),
                  onTap: (){
                    Get.to(NewTaskPage());
                  },
                ),
              );
            } else {
              final tasks = snapshot.data!;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    trailing: IconButton(
                        onPressed: (){
                          deleteTask(task['id']);
                        },
                        icon: Icon(Icons.delete)),
                    title: Text(task['name']),
                    onTap: () {

                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(71, 240, 255, 1.0),
        onPressed: () {
          // showbottomsheet();
          Get.to(NewTaskPage());

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
