import '../../../../core/errors/failure.dart';
import '../entities/timelog_entry.dart';
import '../repository/timelog_repo.dart';
import 'package:dartz/dartz.dart';

class AddTimeLog {
  final TimeLogRepository repository;

  AddTimeLog({required this.repository});

  Future<Either<Failure, void>> call(TimeLogEntry timeLog) async {
    return await repository.addTimeLog(timeLog);
  }
}