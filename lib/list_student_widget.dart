import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/db/functions/db_functions.dart';
import 'package:hive_database/db/model/data_model.dart';
import 'package:hive_database/update_screen.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: ((ctx, index) {
            final data = studentList[index];
            dynamic avatar;
            if (studentList[index].imagepath != null) {
              avatar = base64Decode(studentList[index].imagepath);
            }
            return ListTile(
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
              title: Text(data.name),
              subtitle: Text(data.age),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      log("dataaaa ${studentList[index].key}");
                      log("dataaaa ${studentList[index]}");

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
            );
          }),
          separatorBuilder: ((context, index) {
            return const Divider();
          }),
          itemCount: studentList.length,
        );
      },
    );
  }
}
