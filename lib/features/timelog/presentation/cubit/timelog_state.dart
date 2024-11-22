part of 'timelog_cubit.dart';

abstract class TimeLogState extends Equatable {
  const TimeLogState();

  @override
  List<Object?> get props => [];
}

class TimeLogInitial extends TimeLogState {}

class TimeLogLoading extends TimeLogState {}

class TimeLogLoaded extends TimeLogState {
  final List<TimeLogEntry> timeLogs;

  const TimeLogLoaded(this.timeLogs);

  @override
  List<Object> get props => [timeLogs];
}

class TimeLogAdded extends TimeLogState {}

class TimeLogDeleted extends TimeLogState {}

class TimeLogUpdated extends TimeLogState {
  final TimeLogEntry newTimeLog;

  const TimeLogUpdated(this.newTimeLog);

  @override
  List<Object?> get props => [newTimeLog];
}

class TimeLogError extends TimeLogState {
  final String message;

  const TimeLogError(this.message);

  @override
  List<Object> get props => [message];
}
