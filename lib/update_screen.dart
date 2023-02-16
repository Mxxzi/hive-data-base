import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/db/model/data_model.dart';

import 'db/functions/db_functions.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final StudentModel studentModel;

  UpdateScreen({
    required this.index,
    required this.studentModel,
  });

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late final Box box;
  String name = '';
  String age = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.studentModel.name;
    age = widget.studentModel.age;
    _nameController = TextEditingController(text: widget.studentModel.name);
    _ageController = TextEditingController(text: widget.studentModel.age);
    log("${name} ${age}");
  }

  _updateInfo() async {
    log(" _nameController.text ${_nameController.text} ");
    log(" _ageController.text ${_ageController.text} ");
    StudentModel newPerson = StudentModel(
      name: _nameController.text,
      age: _ageController.text,
    );
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(widget.index, newPerson);
    print('Info updated in box!');
    getAllStudents();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      'Updated sucessfully',
      style: TextStyle(color: Colors.green),
    )));
    _nameController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 215, 215),
      appBar: AppBar(
        title: const Text('Update'),
        centerTitle: true,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
        ),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(name),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(age),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)))),
                onPressed: () {
                  _updateInfo();
                },
                icon: const Icon(Icons.update),
                label: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
