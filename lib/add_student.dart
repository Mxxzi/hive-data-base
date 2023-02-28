import 'package:flutter/material.dart';

import 'add_student_widget.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 215, 215),
      appBar: AppBar(
        title: const Text('Add Student'),
        centerTitle: true,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
        ),
        elevation: 10,
      ),
      body: AddStudentWidget(),
    );
  }
}
