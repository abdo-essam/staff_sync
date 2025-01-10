import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../utils/constants.dart';
import 'employee_card.dart';

enum SortBy { name, salary, age }

class EmployeeListWidget extends StatefulWidget {
  final List<Employee> employees;
  final String searchQuery;
  const EmployeeListWidget({
    super.key,
    required this.employees,
    required this.searchQuery,
  });
  @override
  State<EmployeeListWidget> createState() => _EmployeeListWidgetState();
}

class _EmployeeListWidgetState extends State<EmployeeListWidget> {
  SortBy _sortBy = SortBy.name;
  bool _ascending = true;

  List<Employee> get _sortedAndFilteredEmployees {
    List<Employee> filteredList = widget.searchQuery.isEmpty
        ? widget.employees
        : widget.employees.where((employee) {
      final searchLower = widget.searchQuery.toLowerCase();
      return employee.fullName.toLowerCase().contains(searchLower) ||
          employee.email.toLowerCase().contains(searchLower);
    }).toList();

    switch (_sortBy) {
      case SortBy.name:
        filteredList.sort((a, b) => _ascending
            ? a.fullName.compareTo(b.fullName)
            : b.fullName.compareTo(a.fullName));
        break;

      case SortBy.salary:
        filteredList.sort((a, b) => _ascending
            ? a.salary.compareTo(b.salary)
            : b.salary.compareTo(a.salary));
        break;

      case SortBy.age:
        filteredList.sort((a, b) =>
        _ascending ? a.age.compareTo(b.age) : b.age.compareTo(a.age));
        break;
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text('Sort by:'),
              const SizedBox(width: 8),
              DropdownButton<SortBy>(
                value: _sortBy,
                items: SortBy.values
                    .map((sort) => DropdownMenuItem(
                  value: sort,
                  child: Text(sort.name.toUpperCase()),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _sortBy = value);
                  }
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(_ascending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward),
                onPressed: () {
                  setState(() => _ascending = !_ascending);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: _sortedAndFilteredEmployees.isEmpty
              ? const Center(
            child: Text(AppConstants.noEmployeesFound),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _sortedAndFilteredEmployees.length,
            itemBuilder: (context, index) {
              return EmployeeCard(
                employee: _sortedAndFilteredEmployees[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
