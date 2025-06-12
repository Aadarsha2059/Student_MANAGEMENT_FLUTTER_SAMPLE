import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/domain/repository/course_repository.dart';

class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDatasource _courseRemoteDatasource;

  CourseRemoteRepository({
    required CourseRemoteDatasource courseRemoteDatasource,
  }) : _courseRemoteDatasource = courseRemoteDatasource;

  @override
  Future<Either<Failure, void>> addCourse(CourseEntity course) async {
    try {
      await _courseRemoteDatasource.addCourse(course);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String courseId) async {
    try {
      await _courseRemoteDatasource.deleteCourse(courseId);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      final courses = await _courseRemoteDatasource.getCourses();
      return Right(courses);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> createCourse(CourseEntity course) {
    // TODO: implement createCourse
    throw UnimplementedError();
  }
}
