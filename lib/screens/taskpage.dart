import 'package:flutter/material.dart';
import 'package:todo/widgets/bottomsheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Stream<List> Tasks(){
    FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('timestamp',descending: true)
        .snapshots() //chatgpt nhi kiya :)
        .map((snapshot))=> snapshot.docs.map((doc){
          final data = doc.data();
          return{
            'id': doc.id,
            'name':data['task']??'Remainder'
          };
    }).toList();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: ,
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          showbottomsheet();
        },
        child: Icon(Icons.add),),
    );
  }
}
