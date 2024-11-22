import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, void>> addEmployee(Employee employee);
  Future<Either<Failure, List<Employee>>> getAllEmployees();
  Future<Either<Failure, Employee>> getEmployeeById(String id);
  Future<Either<Failure, void>> updateEmployee(Employee employee);
  Future<Either<Failure, void>> deleteEmployee(String id);
}