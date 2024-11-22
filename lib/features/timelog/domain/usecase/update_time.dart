import '../../../../core/errors/failure.dart';
import '../entities/timelog_entry.dart';
import '../repository/timelog_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateTimeLog {
  final TimeLogRepository repository;

  UpdateTimeLog({required this.repository});

  Future<Either<Failure, void>> call(TimeLogEntry timeLog) async {
    return await repository.updateTimeLog(timeLog);
  }
}