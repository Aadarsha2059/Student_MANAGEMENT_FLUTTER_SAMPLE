import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/batch/data/model/batch_api_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/course/data/model/course_api_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';


@JsonSerializable()
class StudentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String fName;
  final String lName;
  final String? image;
  final String phone;
  final BatchApiModel batch;
  final List<CourseApiModel> courses;
  final String username;
  final String password;

  const StudentApiModel({
    this.userId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  // Empty constructor for default usage
  const StudentApiModel.empty()
      : userId = '',
        fName = '',
        lName = '',
        image = '',
        phone = '',
        batch = const BatchApiModel.empty(),
        courses = const [],
        username = '',
        password = '';

  // From JSON (manual)
  factory StudentApiModel.fromJson(Map<String, dynamic> json) {
    return StudentApiModel(
      userId: json['_id'],
      fName: json['fName'],
      lName: json['lName'],
      image: json['image'],
      phone: json['phone'],
      batch: BatchApiModel.fromJson(json['batch']),
      courses: (json['courses'] as List)
          .map((course) => CourseApiModel.fromJson(course))
          .toList(),
      username: json['username'],
      password: json['password'],
    );
  }

  // To JSON (manual)
  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'fName': fName,
      'lName': lName,
      'image': image,
      'phone': phone,
      'batch': batch.toJson(),
      'courses': courses.map((c) => c.toJson()).toList(),
      'username': username,
      'password': password,
    };
  }

  // Convert to Entity
  StudentEntity toEntity() {
    return StudentEntity(
      userId: userId,
      fName: fName,
      lName: lName,
      image: image,
      phone: phone,
      batch: batch.toEntity(),
      courses: courses.map((c) => c.toEntity()).toList(),
      username: username,
      password: password,
    );
  }

  // Convert from Entity
  static StudentApiModel fromEntity(StudentEntity entity) {
    return StudentApiModel(
      userId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phone: entity.phone,
      batch: BatchApiModel.fromEntity(entity.batch),
      courses: entity.courses.map((e) => CourseApiModel.fromEntity(e)).toList(),
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        fName,
        lName,
        image,
        phone,
        batch,
        courses,
        username,
        password,
      ];
}
