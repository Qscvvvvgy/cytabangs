import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timelog/features/user_management/data/data_source/firebase_remote_datasource.dart';
import 'features/user_management/domain/entities/employee.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  EmployeeFirebaseDatasource datasource =
      EmployeeFirebaseDatasource(FirebaseFirestore.instance);

  const employee = Employee(
    id: 'id1',
    name: 'John Doe',
    position: 'Developer',
    department: 'IT',
    contactInfo: 'johndoe@example.com',
  );

  await datasource.addEmployee(employee);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
