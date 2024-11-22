import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timelog/core/errors/failure.dart';
import 'package:timelog/features/timelog/data/data_source/timelog_remote_datasource.dart';
import 'package:timelog/features/timelog/data/repository_impl/timelog_repo_impl.dart';
import 'package:timelog/features/timelog/domain/entities/timelog_entry.dart';
import 'timelog_remote_datasource.mock.dart';

void main() {
  late TimelogRepositoryImplementation timeLogRepository;
  late MockTimeLogRemoteDataSource mockTimeLogRemoteDataSource;

  setUp(() {
    mockTimeLogRemoteDataSource = MockTimeLogRemoteDataSource();
    timeLogRepository = TimelogRepositoryImplementation(
        mockTimeLogRemoteDataSource as TimelogRemoteDataSource);
  });

  group('addTimeLog', () {
    final timeLogEntry = TimeLogEntry(
      id: '123',
      employeeId: '456',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 8)),
      breakTime: const Duration(minutes: 30),
      taskDescription: 'Sample Task',
    );

    test('should return void when addTimeLog succeeds', () async {
      // Arrange: Define the behavior of the mock to return a successful result
      when(() => mockTimeLogRemoteDataSource.addTimeLog(timeLogEntry))
          .thenAnswer((_) async => Future.value());

      // Act: Call the method being tested
      final result = await timeLogRepository.addTimeLog(timeLogEntry);

      // Assert: Check that the method returns a Right(void)
      expect(result, equals(const Right(null)));
      verify(() => mockTimeLogRemoteDataSource.addTimeLog(timeLogEntry))
          .called(1);
    });

    test('should return Failure when addTimeLog fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockTimeLogRemoteDataSource.addTimeLog(timeLogEntry))
          .thenThrow(Exception('Failed to add time log'));

      // Act: Call the method being tested
      final result = await timeLogRepository.addTimeLog(timeLogEntry);

      // Assert: Check that the method returns a Left(Failure)
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockTimeLogRemoteDataSource.addTimeLog(timeLogEntry))
          .called(1);
    });
  });

  group('getTimeLogById', () {
    const String timeLogId = '123';

    final timeLogEntry = TimeLogEntry(
      id: timeLogId,
      employeeId: '456',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 8)),
      breakTime: const Duration(minutes: 30),
      taskDescription: 'Sample Task',
    );

    test('should return TimeLogEntry when getTimeLogById succeeds', () async {
      // Arrange: Define the behavior of the mock to return a successful result
      when(() => mockTimeLogRemoteDataSource.getTimeLogById(timeLogId))
          .thenAnswer((_) async => timeLogEntry);

      // Act: Call the method being tested
      final result = await timeLogRepository.getTimeLogById(timeLogId);

      // Assert: Check that the method returns a Right(TimeLogEntry)
      expect(result, equals(Right(timeLogEntry)));
      verify(() => mockTimeLogRemoteDataSource.getTimeLogById(timeLogId))
          .called(1);
    });

    test('should return Failure when getTimeLogById fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockTimeLogRemoteDataSource.getTimeLogById(timeLogId))
          .thenThrow(Exception('Failed to get time log'));

      // Act: Call the method being tested
      final result = await timeLogRepository.getTimeLogById(timeLogId);

      // Assert: Check that the method returns a Left(Failure)
      expect(result, isA<Left<Failure, TimeLogEntry>>());
      verify(() => mockTimeLogRemoteDataSource.getTimeLogById(timeLogId))
          .called(1);
    });
  });
  group('getTimeLogs', () {
    final List<TimeLogEntry> timeLogList = [
      TimeLogEntry(
        id: '1',
        employeeId: '456',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 8)),
        breakTime: const Duration(minutes: 30),
        taskDescription: 'Task 1',
      ),
      TimeLogEntry(
        id: '2',
        employeeId: '789',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 7)),
        breakTime: const Duration(minutes: 45),
        taskDescription: 'Task 2',
      ),
    ];

    test('should return a list of TimeLogEntries when getTimeLogs succeeds',
        () async {
      // Arrange: Define the behavior of the mock to return a successful result
      when(() => mockTimeLogRemoteDataSource.getTimeLogs(
            employeeId: any(named: 'employeeId'),
            dateRange: any(named: 'dateRange'),
            project: any(named: 'project'),
            task: any(named: 'task'),
          )).thenAnswer((_) async => timeLogList);

      // Act: Call the method being tested
      final result = await timeLogRepository.getTimeLogs();

      // Assert: Check that the method returns Right(List<TimeLogEntry>)
      expect(result, equals(Right(timeLogList)));
      verify(() => mockTimeLogRemoteDataSource.getTimeLogs(
            employeeId: any(named: 'employeeId'),
            dateRange: any(named: 'dateRange'),
            project: any(named: 'project'),
            task: any(named: 'task'),
          )).called(1);
    });

    test('should return Failure when getTimeLogs fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockTimeLogRemoteDataSource.getTimeLogs(
            employeeId: any(named: 'employeeId'),
            dateRange: any(named: 'dateRange'),
            project: any(named: 'project'),
            task: any(named: 'task'),
          )).thenThrow(Exception('Failed to retrieve time logs'));

      // Act: Call the method being tested
      final result = await timeLogRepository.getTimeLogs();

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, List<TimeLogEntry>>>());
      verify(() => mockTimeLogRemoteDataSource.getTimeLogs(
            employeeId: any(named: 'employeeId'),
            dateRange: any(named: 'dateRange'),
            project: any(named: 'project'),
            task: any(named: 'task'),
          )).called(1);
    });
  });
  group('deleteTimeLog', () {
    const String timeLogId = '123';

    test('should return void when deleteTimeLog succeeds', () async {
      // Arrange: Define the behavior of the mock to return success
      when(() => mockTimeLogRemoteDataSource.deleteTimeLog(timeLogId))
          .thenAnswer((_) async => Future.value());

      // Act: Call the method being tested
      final result = await timeLogRepository.deleteTimeLog(timeLogId);

      // Assert: Check that the method returns Right(void)
      expect(result, equals(const Right(null)));
      verify(() => mockTimeLogRemoteDataSource.deleteTimeLog(timeLogId))
          .called(1);
    });

    test('should return Failure when deleteTimeLog fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockTimeLogRemoteDataSource.deleteTimeLog(timeLogId))
          .thenThrow(Exception('Failed to delete time log'));

      // Act: Call the method being tested
      final result = await timeLogRepository.deleteTimeLog(timeLogId);

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockTimeLogRemoteDataSource.deleteTimeLog(timeLogId))
          .called(1);
    });
  });
  group('updateTimeLog', () {
    final TimeLogEntry timeLogEntry = TimeLogEntry(
      id: '123',
      employeeId: '456',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 8)),
      breakTime: const Duration(minutes: 30),
      taskDescription: 'Updated Task',
    );

    test('should return void when updateTimeLog succeeds', () async {
      // Arrange: Define the behavior of the mock to return success
      when(() => mockTimeLogRemoteDataSource.updateTimeLog(timeLogEntry))
          .thenAnswer((_) async => Future.value());

      // Act: Call the method being tested
      final result = await timeLogRepository.updateTimeLog(timeLogEntry);

      // Assert: Check that the method returns Right(void)
      expect(result, equals(const Right(null)));
      verify(() => mockTimeLogRemoteDataSource.updateTimeLog(timeLogEntry))
          .called(1);
    });

    test('should return Failure when updateTimeLog fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockTimeLogRemoteDataSource.updateTimeLog(timeLogEntry))
          .thenThrow(Exception('Failed to update time log'));

      // Act: Call the method being tested
      final result = await timeLogRepository.updateTimeLog(timeLogEntry);

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockTimeLogRemoteDataSource.updateTimeLog(timeLogEntry))
          .called(1);
    });
  });
}
