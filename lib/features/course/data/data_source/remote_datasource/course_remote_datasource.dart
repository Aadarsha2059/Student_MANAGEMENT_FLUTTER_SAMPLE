import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/course/data/data_source/course_data_source.dart';
import 'package:student_management/features/course/data/dto/get_all_course_dto.dart';
import 'package:student_management/features/course/data/model/course_api_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class CourseRemoteDatasource implements ICourseDataSource {
  final ApiService _apiService;

  CourseRemoteDatasource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<void> addCourse(CourseEntity course) async {
    try {
      final courseApiModel = CourseApiModel.fromEntity(course);
      final response = await _apiService.dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.toJson(),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to add course: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to add course: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      final response = await _apiService.dio.delete(
        '${ApiEndpoints.deleteCourse}/$courseId',
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete course: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete course: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllCourse);

      if (response.statusCode == 200) {
        final getAllCourseDto = GetAllCourseDto.fromJson(response.data);
        return CourseApiModel.toEntityList(getAllCourseDto.data);
      } else {
        throw Exception('Failed to fetch courses: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch courses: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // If createCourse is not needed, remove it. Otherwise, implement it properly or leave as:
  @override
  Future<void> createCourse(CourseEntity course) {
    throw UnimplementedError();
  }
}
