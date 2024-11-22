import 'dart:convert';
import '../../domain/entities/timelog_entry.dart';

class TimeLogEntryModel extends TimeLogEntry {
  const TimeLogEntryModel({
    required super.id,
    required super.employeeId,
    required super.startTime,
    required super.endTime,
    required super.breakTime,
    required super.taskDescription,
  });

  // Factory constructor for creating a new TimeLogEntryModel from a map
  factory TimeLogEntryModel.fromMap(Map<String, dynamic> map) {
    return TimeLogEntryModel(
      id: map['id'],
      employeeId: map['employeeId'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      breakTime: Duration(minutes: map['breakTime']),
      taskDescription: map['taskDescription'],
    );
  }

  // Factory constructor for creating a new TimeLogEntryModel from a JSON string
  factory TimeLogEntryModel.fromJson(String source) =>
      TimeLogEntryModel.fromMap(json.decode(source));

  // Convert TimeLogEntryModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'breakTime': breakTime.inMinutes,
      'taskDescription': taskDescription,
    };
  }

  // Convert TimeLogEntryModel to a JSON string
  String toJson() => json.encode(toMap());
}
