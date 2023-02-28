import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/alertWidget.dart';
import 'package:hive_database/db/model/data_model.dart';
import 'package:image_picker/image_picker.dart';

import 'db/functions/db_functions.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final StudentModel studentModel;

  const UpdateScreen({
    required this.index,
    required this.studentModel,
  });

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late final Box box;
  String name = '';
  String age = '';
  String place = '';

  final ImagePicker _picker = ImagePicker();

  XFile? imageXFile;
  String avatarimage = "";
  dynamic picture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.studentModel.name;
    age = widget.studentModel.age;
    place = widget.studentModel.place;
    _nameController = TextEditingController(text: widget.studentModel.name);
    _ageController = TextEditingController(text: widget.studentModel.age);
    _placeController = TextEditingController(text: widget.studentModel.place);
    picture = widget.studentModel.imagepath;
    log("${name} ${age} ${place}");
  }

  _updateInfo() async {
    log(" _nameController.text ${_nameController.text} ");
    log(" _ageController.text ${_ageController.text} ");
    log("_placeController.text ${_placeController}");
    StudentModel newPerson = StudentModel(
        name: _nameController.text,
        age: _ageController.text,
        place: _placeController.text,
        imagepath: picture);
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
    _placeController.clear();
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
              TextFormField(
                controller: _placeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(place),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)))),
                onPressed: () {
                  _getImage();
                },
                icon: const Icon(Icons.update),
                label: const Text('Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertWidget(
                          title: 'Update',
                          content: 'Do you want to update this student log ?',
                          onPressed: () {
                            _updateInfo();
                            Navigator.of(context).pop();
                          },
                        );
                      });
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

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });

    Uint8List avatarimage = await imageXFile!.readAsBytes();

    picture = await base64Encode(avatarimage);
    avatarimage.clear();
    log('${picture}');
  }
}
