import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/employee.dart';
import '../repository/employee_repo.dart';

class GetAllEmployees {
  final EmployeeRepository repository;

  GetAllEmployees({required this.repository});

  Future<Either<Failure, List<Employee>>> call() async {
    return await repository.getAllEmployees();
  }
}