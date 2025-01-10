import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../widgets/employee_detail_card.dart';


class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.fullName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: EmployeeDetailCard(employee: employee),
        ),
      ),
    );
  }
}