import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/failure.dart';
import '../entities/timelog_entry.dart';

abstract class TimeLogRepository {
  Future<Either<Failure, void>> addTimeLog(TimeLogEntry timeLog);
  Future<Either<Failure, List<TimeLogEntry>>> getTimeLogs({
    String? employeeId,
    DateTimeRange? dateRange,
    String? project,
    String? task,
  });
  Future<Either<Failure, TimeLogEntry>> getTimeLogById(String id);
  Future<Either<Failure, void>> updateTimeLog(TimeLogEntry timeLog);
  Future<Either<Failure, void>> deleteTimeLog(String id);
}
