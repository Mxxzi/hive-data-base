import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String place;

  @HiveField(4)
  dynamic imagepath;

  StudentModel(
      {required this.name,
      required this.age,
      required this.place,
      this.id,
      this.imagepath});
}
