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
  Stream<List<Map<String,dynamic>>> Tasks(){
    FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('timestamp',descending: true)
        .snapshots() //chatgpt nhi kiya :)
        .map((snapshot)=> snapshot.docs.map((doc){
          final data = doc.data();
          return{
            'id': doc.id,
            'name':data['task']??'Remainder'
          };
    }).toList());

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: StreamBuilder(

          stream: Tasks(),
          builder:(context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return ListTile(
        onTap: (){},
        //todo listile to add task
      );
    }

    } else {
    final contacts = snapshot.data!;

          }, ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          showbottomsheet();
        },
        child: Icon(Icons.add),),
    );
  }
}
