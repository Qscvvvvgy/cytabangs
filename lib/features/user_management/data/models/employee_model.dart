import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.position,
    required super.department,
    required super.contactInfo,
  });

  /// Converts a Firestore document into an `EmployeeModel` instance
  factory EmployeeModel.fromMap(Map<String, dynamic> map, String id) {
    return EmployeeModel(
      id: id,
      name: map['name'] as String,
      position: map['position'] as String,
      department: map['department'] as String,
      contactInfo: map['contactInfo'] as String,
    );
  }

  /// Converts the `EmployeeModel` into a map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'department': department,
      'contactInfo': contactInfo,
    };
  }
}