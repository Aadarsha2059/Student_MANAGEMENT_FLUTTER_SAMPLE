// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getall_student_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllStudentDTO _$GetAllStudentDTOFromJson(Map<String, dynamic> json) =>
    GetAllStudentDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => StudentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllStudentDTOToJson(GetAllStudentDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
