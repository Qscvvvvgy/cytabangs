import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String position;
  final String department;
  final String contactInfo;

  // Constructor
  const Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
    required this.contactInfo,
  });

  @override
  List<Object> get props => [id]; // Compare Employees by their ID

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, position: $position, department: $department, contactInfo: $contactInfo)';
  }
}
