import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_database/db/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final _id = await studentDB.add(value);

  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(final index) async {
  // log('welcome$id');
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(index);
  getAllStudents();
}
