import 'package:flutter/material.dart';
import '../../../../core/errors/failure.dart';
import '../entities/timelog_entry.dart';
import '../repository/timelog_repo.dart';
import 'package:dartz/dartz.dart';

class GetTimeLogs {
  final TimeLogRepository repository;

  GetTimeLogs({required this.repository});

  Future<Either<Failure, List<TimeLogEntry>>> call({
    String? employeeId,
    DateTimeRange? dateRange,
    String? project,
    String? task,
  }) async {
    return await repository.getTimeLogs(
      employeeId: employeeId,
      dateRange: dateRange,
      project: project,
      task: task,
    );
  }
}