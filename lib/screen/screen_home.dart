import 'package:flutter/material.dart';
import 'package:hive_database/add_student.dart';

import 'package:hive_database/db/functions/db_functions.dart';
import 'package:hive_database/list_student_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return new Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 215, 215),
      appBar: new AppBar(
        title: const Text('Student log'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
        ),
        elevation: 10,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ListStudentWidget()),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => AddStudentScreen()));
          }),
    );
  }
}
