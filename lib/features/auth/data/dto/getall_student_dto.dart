import 'package:json_annotation/json_annotation.dart';
import 'package:student_management/features/auth/data/model/student_api_model.dart';


part 'getall_student_dto.g.dart';

@JsonSerializable()
class GetAllStudentDTO {
  final bool success;
  final int count;
  final List<StudentApiModel> data;

  const GetAllStudentDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  // From JSON
  factory GetAllStudentDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllStudentDTOFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$GetAllStudentDTOToJson(this);
}
