import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/employee.dart';
import '../repository/employee_repo.dart';

class GetEmployeeById {
  final EmployeeRepository repository;

  GetEmployeeById({required this.repository});

  Future<Either<Failure, Employee>> call(String id) async {
    return await repository.getEmployeeById(id);
  }
}