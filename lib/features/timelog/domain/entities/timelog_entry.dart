import 'package:equatable/equatable.dart';

class TimeLogEntry extends Equatable {
  final String id;
  final String employeeId;
  final DateTime startTime;
  final DateTime endTime;
  final Duration breakTime;
  final String taskDescription;

  const TimeLogEntry({
    required this.id,
    required this.employeeId,
    required this.startTime,
    required this.endTime,
    required this.breakTime,
    required this.taskDescription,
  });

  Duration get totalWorkedTime => endTime.difference(startTime) - breakTime;
  @override
  List<Object> get props => [id];
}
