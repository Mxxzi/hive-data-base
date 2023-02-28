import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/alertWidget.dart';
import 'package:hive_database/db/functions/db_functions.dart';
import 'package:hive_database/db/model/data_model.dart';
import 'package:hive_database/update_screen.dart';

class ListStudentWidget extends StatefulWidget {
  ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  TextEditingController searchController = TextEditingController();
  bool _validation = false;

  List<Widget> rowList = [];

  showStudents(List<StudentModel> studentList) async {
    rowList.clear();

    for (int i = 0; i < studentList.length; i++) {
      if (studentList
          .elementAt(i)
          .name
          .toLowerCase()
          .contains(searchController.text.toString())) {
        _validation = false;
        rowList.add(buildStudentWidget(i, studentList));
      }
      //  else {
      //   _validation = true;
      // }
      // log('invalid $_validation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext, List<StudentModel> studentList, Widget? child) {
        showStudents(studentList);
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    showStudents(studentList);
                  });
                },
                controller: searchController,
                style: new TextStyle(
                  color: Colors.black,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.blue),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.blue)),
              ),
              Column(
                children: _validation ? [Text('invalid item list')] : rowList,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildStudentWidget(int index, List<StudentModel> studentList) {
    dynamic avatar;
    final data = studentList[index];
    if (studentList[index].imagepath != null) {
      avatar = base64Decode(studentList[index].imagepath);
    }
    return Column(
      children: [
        ListTile(
          leading: studentList[index].imagepath == null
              ? Icon(Icons.image)
              : CircleAvatar(
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                          child: Image.memory(
                        avatar,
                        fit: BoxFit.fill,
                        width: 70,
                        height: 70,
                      )))),
          title: Row(
            children: [
              Text(data.name),
              SizedBox(
                width: 10,
              ),
              Text(data.age),
            ],
          ),
          subtitle: Text(data.place),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertWidget(
                        title: 'Delete',
                        content: 'Do you want to delete this student log ?',
                        onPressed: () {
                          if (data != null) {
                            deleteStudent(studentList[index].key);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              'Deleted sucessfully',
                              style: TextStyle(color: Colors.red),
                            )));
                          } else {
                            print('Student id is null.Unable to delete');
                          }
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => UpdateScreen(
                                index: index,
                                studentModel: studentList[index])));
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
        ),
      ],
    );
  }
}
