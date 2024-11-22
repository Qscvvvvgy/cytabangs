import '../../domain/entities/employee.dart';

abstract class EmployeeRemoteDataSource {
  Future<void> addEmployee(Employee employee);
  Future<List<Employee>> getAllEmployees();
  Future<Employee> getEmployeeById(String id);
  Future<void> updateEmployee(Employee employee);
  Future<void> deleteEmployee(String id);
}