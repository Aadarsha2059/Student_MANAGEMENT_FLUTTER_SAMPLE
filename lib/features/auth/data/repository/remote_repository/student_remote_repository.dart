import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/data/data_source/sudent_data_source.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class StudentRemoteRepository implements IStudentRepository {
  final IStudentDataSource _studentRemoteDatasource;

  StudentRemoteRepository({required IStudentDataSource studentRemoteDatasource})
      : _studentRemoteDatasource = studentRemoteDatasource;

  @override
  Future<Either<Failure, void>> registerStudent(StudentEntity student) async {
    try {
      await _studentRemoteDatasource.registerStudent(student);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginStudent(String username, String password) async {
    try {
      final token = await _studentRemoteDatasource.loginStudent(username, password);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final url = await _studentRemoteDatasource.uploadProfilePicture(file.path);
      return Right(url);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> getCurrentUser() async {
    try {
      final user = await _studentRemoteDatasource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
