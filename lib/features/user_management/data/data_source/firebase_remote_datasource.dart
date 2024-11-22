import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/employee.dart';
import '../models/employee_model.dart';
import 'employee_remote_datasource.dart';

class EmployeeFirebaseDatasource implements EmployeeRemoteDataSource {
  final FirebaseFirestore _firestore;

  EmployeeFirebaseDatasource(this._firestore);

  @override
  Future<void> addEmployee(Employee employee) async {
    try {
      final employeeDocRef = _firestore.collection('employees').doc();
      final employeeModel = EmployeeModel(
        id: employeeDocRef.id,
        name: employee.name,
        position: employee.position,
        department: employee.department,
        contactInfo: employee.contactInfo,);
      await employeeDocRef.set(employeeModel.toMap());
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
  Future<void> deleteEmployee(String id) async {
    try {
      await _firestore.collection('employees').doc(id).delete();
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
  Future<Employee> getEmployeeById(String id) async {
    try {
      final docSnapshot =
          await _firestore.collection('employees').doc(id).get();
      if (!docSnapshot.exists) {
        throw const APIException(
            message: 'Employee not found', statusCode: '404');
      }

      final data = docSnapshot.data()!;
      return Employee(
        id: docSnapshot.id,
        name: data['name'] as String,
        position: data['position'] as String,
        department: data['department'] as String,
        contactInfo: data['contactInfo'] as String,
      );
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final employeeModel = EmployeeModel(
        id: employee.id,
        name: employee.name,
        position: employee.position,
        department: employee.department,
        contactInfo: employee.contactInfo);
    try {
      await _firestore.collection('employees').doc(employee.id).update(employeeModel.toMap());
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
  Future<List<Employee>> getAllEmployees() async {
    try {
      final querySnapshot = await _firestore.collection('employees').get();
      return querySnapshot.docs.map((doc) {
        return EmployeeModel.fromMap(doc.data(), doc.id);
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
}
