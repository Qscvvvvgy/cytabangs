import '../../../../core/errors/failure.dart';
import '../repository/timelog_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteTimeLog {
  final TimeLogRepository repository;

  DeleteTimeLog({required this.repository});

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteTimeLog(id);
  }
}
