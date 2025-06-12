import 'dart:io';

import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_constant.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/auth/data/data_source/sudent_data_source.dart';
import 'package:student_management/features/auth/data/model/student_api_model.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

class StudentRemoteDatasource implements IStudentDataSource {
  final ApiService _apiService;

  StudentRemoteDatasource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<void> registerStudent(StudentEntity studentData) async {
    try {
      final studentApiModel = StudentApiModel.fromEntity(studentData);

      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: studentApiModel.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception('Registration failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during registration: $e');
    }
  }

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'] as String;
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during login: $e');
    }
  }

 @override
Future<String> uploadProfilePicture(String file) async {
  try {
    final formData = FormData.fromMap({
      'profile_picture': await MultipartFile.fromFile(file),
    });

    final response = await _apiService.dio.post(
      ApiEndpoints.uploadImage,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200 && response.data['url'] != null) {
      return response.data['url'] as String;
    } else {
      throw Exception('Profile picture upload failed: ${response.statusMessage}');
    }
  } on DioException catch (e) {
    throw Exception('Profile picture upload failed: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected error during upload: $e');
  }
}


  @override
  Future<StudentEntity> getCurrentUser() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllStudent);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final studentModel = StudentApiModel.fromJson(response.data);
        return studentModel.toEntity();
      } else {
        throw Exception('Failed to fetch current user: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch current user: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching user: $e');
    }
  }
}

