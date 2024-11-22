import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repository/employee_repo.dart';

class DeleteEmployee {
  final EmployeeRepository repository;

  DeleteEmployee({required this.repository});

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteEmployee(id);
  }
}