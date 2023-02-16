import 'package:flutter/material.dart';
import 'package:hive_database/add_student_widget.dart';
import 'package:hive_database/db/functions/db_functions.dart';
import 'package:hive_database/list_student_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 215, 215),
      appBar: AppBar(
        title: const Text('Student log'),
        centerTitle: true,
        backgroundColor: Colors.black,
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
          AddStudentWidget(),
          const Expanded(child: ListStudentWidget()),
        ],
      )),
    );
  }
}
