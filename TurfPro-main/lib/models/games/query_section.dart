import 'package:flutter/material.dart';

class QuerySection extends StatelessWidget {
  const QuerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Queries (2)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          _buildQueryItem('Do we have to bring any cricketing gear?', 'Mohammed Ramees', '4 hours ago'),
          const Divider(),
          _buildQueryItem('Is the turf air conditioned?', 'Nivas Kilpura', '4 hours ago'),
        ],
      ),
    );
  }

  Widget _buildQueryItem(String query, String user, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query),
        const SizedBox(height: 4),
        Text('$user | $time', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}