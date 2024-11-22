import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/employee.dart';
import '../repository/employee_repo.dart';

class UpdateEmployee {
  final EmployeeRepository repository;

  UpdateEmployee({required this.repository});

  Future<Either<Failure, void>> call(Employee employee) async {
    return await repository.updateEmployee(employee);
  }
}
