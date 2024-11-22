import '../../../../core/errors/failure.dart';
import '../entities/timelog_entry.dart';
import '../repository/timelog_repo.dart';
import 'package:dartz/dartz.dart';

class GetTimeLogById {
  final TimeLogRepository repository;

  GetTimeLogById({required this.repository});

  Future<Either<Failure, TimeLogEntry>> call(String id) async {
    return await repository.getTimeLogById(id);
  }
}