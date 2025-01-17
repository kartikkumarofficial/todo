import 'package:flutter/material.dart';
import 'package:todo/widgets/bottomsheet.dart';


class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:(){
            showbottomsheet();
          } ),
    );
  }
}
