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

  Future<void> deleteTask () async{
    try{
      await FirebaseFirestore.instance.collection('tasks').doc(taskId]).delete();
      Get.showSnackbar(
        GetSnackBar(
          title: 'Task',
          message: 'Task Deleted',
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
        title: Text('To Do List'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Tasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available. Add a task!'));
          } else {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['name']),
                  onTap: () {

                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showbottomsheet();
          Get.to(NewTaskPage());

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
