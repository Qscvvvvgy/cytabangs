import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/timelog_entry.dart';
import '../models/timelog_entrymodel.dart';
import 'timelog_remote_datasource.dart';

class TimelogFirebaseDatasource implements TimelogRemoteDataSource {
  final FirebaseFirestore _firestore;

  TimelogFirebaseDatasource(this._firestore);

  @override
  Future<void> addTimeLog(TimeLogEntry timeLog) async {
    try {
      final timeLogEntryDocRef = _firestore.collection('timeLog').doc();
      final timeLogEntryModel = TimeLogEntryModel(
          id: timeLogEntryDocRef.id,
          employeeId: timeLog.employeeId,
          startTime: timeLog.startTime,
          endTime: timeLog.endTime,
          breakTime: timeLog.breakTime,
          taskDescription: timeLog.taskDescription);
      await timeLogEntryDocRef.set(timeLogEntryModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> deleteTimeLog(String id) async {
    try {
      await _firestore.collection('timeLogs').doc(id).delete();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<TimeLogEntry> getTimeLogById(String id) async {
    try {
      final doc = await _firestore.collection('timeLogs').doc(id).get();
      if (doc.exists) {
        return TimeLogEntry(
          id: doc.id,
          employeeId: doc.data()!['employeeId'],
          startTime: (doc.data()!['startTime'] as Timestamp).toDate(),
          endTime: (doc.data()!['endTime'] as Timestamp).toDate(),
          breakTime: (doc.data()!['breakTime']),
          taskDescription: doc.data()!['taskDescription'],
        );
      } else {
        throw Exception('Time log not found');
      }
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<List<TimeLogEntry>> getTimeLogs({
    String? employeeId,
    DateTimeRange? dateRange,
    String? project,
    String? task,
  }) async {
    try {
      var query = _firestore
          .collection('timeLogs')
          .where('employeeId', isEqualTo: employeeId);

      if (dateRange != null) {
        query =
            query.where('startTime', isGreaterThanOrEqualTo: dateRange.start);
        query = query.where('endTime', isLessThanOrEqualTo: dateRange.end);
      }

      if (project != null) {
        query = query.where('project', isEqualTo: project);
      }

      if (task != null) {
        query = query.where('taskDescription', isEqualTo: task);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) {
        return TimeLogEntry(
          id: doc.id,
          employeeId: doc.data()['employeeId'],
          startTime: (doc.data()['startTime'] as Timestamp).toDate(),
          endTime: (doc.data()['endTime'] as Timestamp).toDate(),
          breakTime: (doc.data()['breakTime']),
          taskDescription: doc.data()['taskDescription'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> updateTimeLog(TimeLogEntry timeLog) async {
    final timeLogEntryModel = TimeLogEntryModel(
        id: timeLog.id,
        employeeId: timeLog.employeeId,
        startTime: timeLog.startTime,
        endTime: timeLog.endTime,
        breakTime: timeLog.breakTime,
        taskDescription: timeLog.taskDescription);
    try {
      await _firestore.collection('timeLogs').doc(timeLog.id).update(timeLogEntryModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }
}
