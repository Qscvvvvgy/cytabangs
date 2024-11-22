import 'package:flutter/material.dart';

import '../../domain/entities/timelog_entry.dart';

abstract class TimelogRemoteDataSource {
  Future<void> addTimeLog(TimeLogEntry timeLog);
  Future<List<TimeLogEntry>> getTimeLogs({
    String? employeeId,
    DateTimeRange? dateRange,
    String? project,
    String? task,
  });
  Future<TimeLogEntry> getTimeLogById(String id);
  Future<void> updateTimeLog(TimeLogEntry timeLog);
  Future<void> deleteTimeLog(String id);
}
