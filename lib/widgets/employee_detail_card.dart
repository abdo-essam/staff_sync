import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeeDetailCard extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailCard({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: employee.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    '${employee.firstName[0]}${employee.lastName[0]}',
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection('Personal Information'),
                _buildInfoRow('Name', employee.fullName),
                _buildInfoRow('Email', employee.email),
                _buildInfoRow('Phone', employee.formattedPhone),
                _buildInfoRow('Age', '${employee.age} years'),
                _buildInfoRow('Date of Birth', employee.dob),

                const SizedBox(height: 16),
                _buildInfoSection('Professional Information'),
                _buildInfoRow('ID', '#${employee.id}'),
                _buildInfoRow('Salary', employee.formattedSalary),

                const SizedBox(height: 16),
                _buildInfoSection('Address'),
                _buildInfoRow('Location', employee.address),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}