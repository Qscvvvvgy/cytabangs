import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/employee.dart';
import '../repository/employee_repo.dart';

class AddEmployee {
  final EmployeeRepository repository;

  AddEmployee({required this.repository});

  Future<Either<Failure, void>> call(Employee employee) async {
    return await repository.addEmployee(employee);
  }
}