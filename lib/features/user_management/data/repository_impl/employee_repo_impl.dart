import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/employee.dart';
import '../../domain/repository/employee_repo.dart';
import '../data_source/employee_remote_datasource.dart';

class EmployeeRepositoryImplementation implements EmployeeRepository {
  final EmployeeRemoteDataSource _remoteDataSource;

  EmployeeRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> addEmployee(Employee employee) async {
    try {
      return Right(await _remoteDataSource.addEmployee(employee));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(String id) async {
    try {
      return Right(await _remoteDataSource.deleteEmployee(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployee(Employee employee) async {
    try {
      return Right(await _remoteDataSource.updateEmployee(employee));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Employee>> getEmployeeById(String id) async {
    try {
      return Right(await _remoteDataSource.getEmployeeById(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Employee>>> getAllEmployees() async {
    try {
      return Right(await _remoteDataSource.getAllEmployees());
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
