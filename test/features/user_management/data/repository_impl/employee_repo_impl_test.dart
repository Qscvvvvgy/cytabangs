import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timelog/core/errors/failure.dart';
import 'package:timelog/features/user_management/data/data_source/employee_remote_datasource.dart';
import 'package:timelog/features/user_management/data/repository_impl/employee_repo_impl.dart';
import 'package:timelog/features/user_management/domain/entities/employee.dart';
import 'employee_remote_datasource.mock.dart';

void main() {
  late EmployeeRepositoryImplementation employeeRepository;
  late MockEmployeeRemoteDataSource mockEmployeeRemoteDataSource;

  setUp(() {
    // Initialize the mock and repository
    mockEmployeeRemoteDataSource = MockEmployeeRemoteDataSource();
    employeeRepository = EmployeeRepositoryImplementation(
      mockEmployeeRemoteDataSource as EmployeeRemoteDataSource,
    );
  });

  const Employee employee = Employee(
    id: '1',
    name: 'John Doe',
    position: 'Developer',
    department: 'Engineering',
    contactInfo: 'john.doe@example.com',
  );
  final tEmployees = [employee];

  group('addEmployee', () {
    test('should return void when addEmployee succeeds', () async {
      // Arrange: Define the behavior of the mock to return success
      when(() => mockEmployeeRemoteDataSource.addEmployee(employee))
          .thenAnswer((_) async => Future.value());

      // Act: Call the method being tested
      final result = await employeeRepository.addEmployee(employee);

      // Assert: Check that the method returns Right(void)
      expect(result, equals(const Right(null)));
      verify(() => mockEmployeeRemoteDataSource.addEmployee(employee))
          .called(1);
    });

    test('should return Failure when addEmployee fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockEmployeeRemoteDataSource.addEmployee(employee))
          .thenThrow(Exception('Failed to add employee'));

      // Act: Call the method being tested
      final result = await employeeRepository.addEmployee(employee);

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockEmployeeRemoteDataSource.addEmployee(employee))
          .called(1);
    });
  });

  group('getEmployeeById', () {
    test('should return Employee when getEmployeeById succeeds', () async {
      // Arrange: Define the behavior of the mock to return the employee
      when(() => mockEmployeeRemoteDataSource.getEmployeeById('1'))
          .thenAnswer((_) async => Future.value(employee));

      // Act: Call the method being tested
      final result = await employeeRepository.getEmployeeById('1');

      // Assert: Check that the method returns Right(employee)
      expect(result, equals(const Right(employee)));
      verify(() => mockEmployeeRemoteDataSource.getEmployeeById('1')).called(1);
    });

    test('should return Failure when getEmployeeById fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockEmployeeRemoteDataSource.getEmployeeById('1'))
          .thenThrow(Exception('Failed to get employee'));

      // Act: Call the method being tested
      final result = await employeeRepository.getEmployeeById('1');

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, Employee>>());
      verify(() => mockEmployeeRemoteDataSource.getEmployeeById('1')).called(1);
    });
  });

  group('getAllEmployees', () {
    test('should return a list of employees when getAllEmployees succeeds',
        () async {
      // Arrange: Define the behavior of the mock to return the list of employees
      when(() => mockEmployeeRemoteDataSource.getAllEmployees())
          .thenAnswer((_) async => tEmployees);

      // Act: Call the method being tested
      final result = await employeeRepository.getAllEmployees();

      // Assert: Check that the method returns Right(list of employees)
      expect(result, equals(Right(tEmployees)));
      verify(() => mockEmployeeRemoteDataSource.getAllEmployees()).called(1);
    });

    test('should return Failure when getAllEmployees fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockEmployeeRemoteDataSource.getAllEmployees())
          .thenThrow(Exception('Failed to get employees'));

      // Act: Call the method being tested
      final result = await employeeRepository.getAllEmployees();

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, List<Employee>>>());
      verify(() => mockEmployeeRemoteDataSource.getAllEmployees()).called(1);
    });
  });
  group('deleteEmployee', () {
    const String employeeId = '1';

    test('should return void when deleteEmployee succeeds', () async {
      // Arrange: Define the behavior of the mock to complete successfully
      when(() => mockEmployeeRemoteDataSource.deleteEmployee(employeeId))
          .thenAnswer((_) async => Future.value());

      // Act: Call the method being tested
      final result = await employeeRepository.deleteEmployee(employeeId);

      // Assert: Check that the method returns Right(void)
      expect(result, equals(const Right(null)));
      verify(() => mockEmployeeRemoteDataSource.deleteEmployee(employeeId))
          .called(1);
    });

    test('should return Failure when deleteEmployee fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockEmployeeRemoteDataSource.deleteEmployee(employeeId))
          .thenThrow(Exception('Failed to delete employee'));

      // Act: Call the method being tested
      final result = await employeeRepository.deleteEmployee(employeeId);

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockEmployeeRemoteDataSource.deleteEmployee(employeeId))
          .called(1);
    });
  });
  group('updateEmployee', () {
    test('should return void when updateEmployee succeeds', () async {
      // Arrange: Define the behavior of the mock to return success
      when(() => mockEmployeeRemoteDataSource.updateEmployee(employee))
          .thenAnswer((_) async => Future.value());

      // Act: Call the method being tested
      final result = await employeeRepository.updateEmployee(employee);

      // Assert: Check that the method returns Right(void)
      expect(result, equals(const Right(null)));
      verify(() => mockEmployeeRemoteDataSource.updateEmployee(employee))
          .called(1);
    });

    test('should return Failure when updateEmployee fails', () async {
      // Arrange: Define the behavior of the mock to throw an exception
      when(() => mockEmployeeRemoteDataSource.updateEmployee(employee))
          .thenThrow(Exception('Failed to update employee'));

      // Act: Call the method being tested
      final result = await employeeRepository.updateEmployee(employee);

      // Assert: Check that the method returns Left(Failure)
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockEmployeeRemoteDataSource.updateEmployee(employee))
          .called(1);
    });
  });
}
