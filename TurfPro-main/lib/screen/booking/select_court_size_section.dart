import 'package:flutter/material.dart';

class SelectCourtSizeSection extends StatelessWidget {
  const SelectCourtSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select court size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildCourtSizeOption('Half court'),
            const SizedBox(width: 16),
            _buildCourtSizeOption('Full court'),
          ],
        ),
      ],
    );
  }

  Widget _buildCourtSizeOption(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: false,
    );
  }
}