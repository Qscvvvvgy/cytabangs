import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/timelog_entry.dart';
import '../../domain/repository/timelog_repo.dart';
import '../data_source/timelog_remote_datasource.dart';

class TimelogRepositoryImplementation implements TimeLogRepository {
  final TimelogRemoteDataSource _remoteDataSource;

  const TimelogRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> addTimeLog(TimeLogEntry timeLog) async {
    try {
      return Right(await _remoteDataSource.addTimeLog(timeLog));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTimeLog(String id) async {
    try {
      return Right(await _remoteDataSource.deleteTimeLog(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeLogEntry>> getTimeLogById(String id) async {
    try {
      return Right(await _remoteDataSource.getTimeLogById(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TimeLogEntry>>> getTimeLogs(
      {String? employeeId,
      DateTimeRange? dateRange,
      String? project,
      String? task}) async {
    try {
      return Right(await _remoteDataSource.getTimeLogs());
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTimeLog(TimeLogEntry timeLog) async {
    try {
      return Right(await _remoteDataSource.updateTimeLog(timeLog));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
