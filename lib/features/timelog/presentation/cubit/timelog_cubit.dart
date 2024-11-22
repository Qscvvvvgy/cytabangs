import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:timelog/core/errors/failure.dart';
import 'package:timelog/features/timelog/domain/entities/timelog_entry.dart';
import '../../domain/usecase/addtime.dart';
import '../../domain/usecase/delete_time.dart';
import '../../domain/usecase/gettime.dart';
import '../../domain/usecase/update_time.dart';

part 'timelog_state.dart';

const String noInternetErrorMessage =
    "Sync Failed: Changes saved on you device and will sync once you're back online.";

class TimeLogCubit extends Cubit<TimeLogState> {
  final AddTimeLog addTimeLogUseCase;
  final DeleteTimeLog deleteTimeLogUseCase;
  final GetTimeLogs getTimeLogsUseCase;
  // final GetTimeLogById getTimeLogByIdUseCase;
  final UpdateTimeLog updateTimeLogUseCase;

  List<TimeLogEntry> _timeLogsCache = [];

  TimeLogCubit({
    required this.addTimeLogUseCase,
    required this.deleteTimeLogUseCase,
    required this.getTimeLogsUseCase,
    // required this.getTimeLogByIdUseCase,
    required this.updateTimeLogUseCase,
  }) : super(TimeLogInitial());

  // Fetch all Time Logs and update cache
  Future<void> getTimeLogs() async {
    emit(TimeLogLoading());
    final result = await getTimeLogsUseCase();
    result.fold(
      (failure) => emit(TimeLogError(failure.message)),
      (timelogs) {
        _timeLogsCache = timelogs;
        emit(TimeLogLoaded(timelogs));
      },
    );
  }

  // Handle Add Time Log
  Future<void> addTimeLogToList(TimeLogEntry timeLog) async {
    try {
      await addTimeLogUseCase(timeLog);
      _timeLogsCache.add(timeLog);
      emit(TimeLogLoaded(_timeLogsCache));
    } catch (e) {
      emit(const TimeLogError('Failed to add time log'));
    }
  }

  // Handle Update Time Log
  Future<void> updateTimeLogs(TimeLogEntry timelog) async {
    emit(TimeLogLoading());
    final result = await updateTimeLogUseCase(timelog);
    result.fold(
      (failure) => emit(TimeLogError(failure.message)),
      (_) {
        final index = _timeLogsCache.indexWhere((e) => e.id == timelog.id);
        if (index != -1) {
          _timeLogsCache[index] = timelog;
          emit(TimeLogLoaded(List.from(_timeLogsCache)));
        } else {
          emit(const TimeLogError("Timelog not found in cached"));
        }
      },
    );
  }

  Future<void> deleteTimeLog(String id) async {
    emit(TimeLogLoading());

    try {
      final Either<Failure, void> result = await deleteTimeLogUseCase
          .call(id)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out."));

      result.fold((failure) => emit(TimeLogError(failure.message)), (_) {
        emit(TimeLogDeleted());
      });
    } catch (_) {
      emit(const TimeLogError(noInternetErrorMessage));
    }
  }
}
